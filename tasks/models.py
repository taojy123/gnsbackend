
from django.conf import settings
from django.db import models
from django.utils import timezone
from easyserializer import SerializeableObject


STATE_CHOICE = (
    (1, '进行中'),
    (2, '成功'),
    (3, '失败'),
)


class App(models.Model, SerializeableObject):

    name = models.CharField(max_length=100, blank=True)

    def __str__(self):
        return self.name

    @property
    def status(self):
        if self.project:
            return self.project.status
        return '就绪'

    @property
    def percent(self):
        if self.project:
            return self.project.percent
        return 0

    @property
    def project(self):
        return self.project_set.order_by('-id').first()

    def default_exclude_fields(self):
        return ['objects', 'pk']


class Project(models.Model, SerializeableObject):
    app = models.ForeignKey(App, on_delete=models.CASCADE)
    name = models.CharField(max_length=100, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

    @property
    def finished_at(self):
        t = self.buildingtask_set.filter(finished_at__isnull=False).order_by('-finished_at').first()
        if t:
            return t.finished_at
        t = self.etltask_set.filter(finished_at__isnull=False).order_by('-finished_at').first()
        if t:
            return t.finished_at
        return None

    @property
    def status(self):
        if self.buildingtask_set.exists():
            t = self.buildingtask_set.filter(state=3).first()
            if t:
                return '%s 失败' % t
            t = self.buildingtask_set.filter(state=1).first()
            if t:
                return '%s 进行中' % t
            return '全部完成'

        for step in [2, 1]:
            t = self.etltask_set.filter(step=step).first()
            if t:
                if t.state == 1:
                    return '%s 进行中' % t
                if t.state == 2:
                    return '%s 完成' % t
                if t.state == 3:
                    return '%s 失败' % t
        return '等待中'

    @property
    def percent(self):
        if self.buildingtask_set.filter(step=2, state=2).exists():
            return 100
        if self.buildingtask_set.filter(step=2).exists():
            return 81
        if self.buildingtask_set.filter(step=1).exists():
            return 67
        if self.etltask_set.filter(step=2).exists():
            return 38
        if self.etltask_set.filter(step=1).exists():
            return 12
        return 0

    @property
    def etltasks(self):
        return list(self.etltask_set.order_by('step'))

    @property
    def buildingtasks(self):
        return list(self.buildingtask_set.order_by('step'))

    @property
    def duration(self):
        t = self.finished_at or timezone.now()
        return int((t - self.created_at).total_seconds())

    def default_exclude_fields(self):
        return ['objects', 'pk', 'app']


class ETLTask(models.Model, SerializeableObject):
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    name = models.CharField(max_length=100, blank=True)
    step = models.IntegerField(default=1)
    info = models.TextField(blank=True)
    state = models.IntegerField(choices=STATE_CHOICE, default=1)
    created_at = models.DateTimeField(auto_now_add=True)
    finished_at = models.DateTimeField(blank=True, null=True)

    def __str__(self):
        return self.name

    @property
    def app(self):
        return self.project.app

    @property
    def status(self):
        return self.get_state_display()

    @property
    def duration(self):
        t = self.finished_at or timezone.now()
        return int((t - self.created_at).total_seconds())

    def default_exclude_fields(self):
        return ['objects', 'pk', 'app', 'project']

    def get_detail_serialization(self):
        r = self.serialize()
        r['project_name'] = self.project.name
        r['app_name'] = self.app.name
        return r


class BuildingTask(models.Model, SerializeableObject):
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    name = models.CharField(max_length=100, blank=True)
    step = models.IntegerField(default=1)
    info = models.TextField(blank=True)
    dist = models.CharField(max_length=100, blank=True)
    target = models.CharField(max_length=300, blank=True)
    state = models.IntegerField(choices=STATE_CHOICE, default=1)
    created_at = models.DateTimeField(auto_now_add=True)
    finished_at = models.DateTimeField(blank=True, null=True)

    def __str__(self):
        return self.name

    @property
    def app(self):
        return self.project.app

    @property
    def status(self):
        return self.get_state_display()

    @property
    def ks(self):
        if self.app.name != '借转贷应用':
            if self.step == 1:
                return 0.45
            else:
                return 0.51
        raise 1

    @property
    def duration(self):
        t = self.finished_at or timezone.now()
        return int((t - self.created_at).total_seconds())

    def default_exclude_fields(self):
        return ['objects', 'pk', 'app', 'project']

    def get_detail_serialization(self):
        r = self.serialize()
        r['project_name'] = self.project.name
        r['app_name'] = self.app.name
        return r



