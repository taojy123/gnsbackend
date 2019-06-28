from django.contrib import admin
from tasks.models import App, Project, ETLTask, BuildingTask


class CommonAdmin(admin.ModelAdmin):

    list_per_page = 50
    list_max_show_all = 5000

    def lookup_allowed(self, lookup, value):
        return True


@admin.register(App)
class AppAdmin(CommonAdmin):
    list_display = ('id', 'name', 'status', 'input_dir', 'output_dir')


@admin.register(Project)
class ProjectAdmin(CommonAdmin):
    list_display = ('id', 'app', 'name', 'status')


@admin.register(ETLTask)
class ETLTaskAdmin(CommonAdmin):
    list_display = ('id', 'app', 'project', 'name', 'step', 'status')


@admin.register(BuildingTask)
class BuildingTaskAdmin(CommonAdmin):
    list_display = ('id', 'app', 'project', 'name', 'dist', 'target', 'status')


