
import os
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "gns.settings")

import django
django.setup()

import time
import traceback
import pymysql
from django.utils import timezone
from tasks.models import App



"""
cursor.execute("call  clean_table();")
cursor.execute("load data  infile 'D:/mysql-5.7.26-winx64/data/user_info.txt' into table  gns_poc.user_info;")
cursor.execute("load data  infile 'D:/mysql-5.7.26-winx64/data/acc_info.txt' into table  gns_poc.acc_info;")
cursor.execute("load data  infile 'D:/mysql-5.7.26-winx64/data/bal_info.txt' into table  gns_poc.bal_info;")
cursor.execute("load data  infile 'D:/mysql-5.7.26-winx64/data/tran_info.txt' into table  gns_poc.tran_info;")

cursor.execute("call insert_summary();")

cursor.execute("call insert_sxj();")
"""


pjoin = os.path.join


WATCH_DIR = pjoin(os.getcwd(), 'input')
TARGET_DIR = pjoin(os.getcwd(), 'output')
DB_CONFIG = {
    # 'host': '192.168.60.167',
    'host': '127.0.0.1',
    'user': 'root',
    'password': 'macroflag.com',
    'db': 'gns_poc',
    'charset': 'utf8mb4',
    # 'cursorclass': pymysql.cursors.DictCursor,
}


for dirname in [WATCH_DIR, TARGET_DIR]:
    if not os.path.exists(dirname):
        os.makedirs(dirname)


def getfile(fname):
    path = pjoin(WATCH_DIR, fname)
    for encoding in ['utf8', 'gbk']:
        try:
            return open(path, encoding=encoding).read().replace('\ufeff', '').strip()
        except:
            continue


def tryprint(*args, **kwargs):
    try:
        print(*args, **kwargs)
    except Exception as e:
        print(e)


def etl_step1(project):
    tryprint(1)
    task = project.etltask_set.create(name='数据处理到数据库中', step=1, state=1)
    connection = pymysql.connect(**DB_CONFIG)
    try:
        with connection.cursor() as cursor:
            sql = "call  clean_table();"
            print(sql)
            cursor.execute(sql)
            for name in ['user_info', 'acc_info', 'bal_info', 'tran_info']:
                path = pjoin(WATCH_DIR, name + '.txt').__repr__()
                # path = pjoin('D:\\mysql-5.7.26-winx64\\data', name + '.txt').__repr__()
                sql = "load data infile %s into table  gns_poc.%s;" % (path, name)
                print(sql)
                cursor.execute(sql)
            connection.commit()
        task.state = 2
    except:
        err = traceback.format_exc()
        print(err)
        task.info = err
        task.state = 3
    finally:
        connection.close()
        task.save()
    task.finished_at = timezone.now()
    task.save()

    if task.state == 2:
        etl_step2(project)


def etl_step2(project):
    tryprint(2)
    task = project.etltask_set.create(name='将分散数据表拼成宽表', step=2, state=1)
    connection = pymysql.connect(**DB_CONFIG)
    try:
        with connection.cursor() as cursor:
            sql = "call insert_summary();"
            print(sql)
            cursor.execute(sql)
            connection.commit()
        task.state = 2
    except:
        err = traceback.format_exc()
        print(err)
        task.info = err
        task.state = 3
    finally:
        connection.close()
        task.save()
    task.finished_at = timezone.now()
    task.save()

    if task.state == 2:
        building_step1(project)


def building_step1(project):
    tryprint(3)
    task = project.buildingtask_set.create(name='响应模型计算', step=1, state=1)

    if project.app.name == '借转贷应用':
        connection = pymysql.connect(**DB_CONFIG)
        try:
            with connection.cursor() as cursor:
                sql = "call insert_sxj();"
                print(sql)
                cursor.execute(sql)
                connection.commit()
                cursor.execute("select * from sxj;")
                rs = cursor.fetchall()
                dist = 'sxj.txt'
                path = pjoin(TARGET_DIR, dist)
                f = open(path, 'w')
                for r in rs:
                    r = [str(v) for v in r]
                    f.write(','.join(r))
                    f.write('\n')
                f.close()

            task.state = 2
            task.dist = dist
            task.target = TARGET_DIR
        except:
            err = traceback.format_exc()
            print(err)
            task.info = err
            task.state = 3
        finally:
            connection.close()
            task.save()
    else:
        time.sleep(12)
        task.state = 2
        task.dist = 'ret2.txt'
        task.target = 'C:/output/result1/ret2.txt'

    task.finished_at = timezone.now()
    task.save()

#     if task.state == 2:
#         building_step2(project)
#
#
# def building_step2(project):
#     tryprint(4)
#     task = project.buildingtask_set.create(name='逾期模型计算', step=2, state=1)
#     time.sleep(8)
#     task.state = 2
#     task.dist = 'ret.txt'
#     task.target = 'C:/output/result2/'
#     task.finished_at = timezone.now()
#     task.save()


while True:

    time.sleep(5)

    fnames = os.listdir(WATCH_DIR)
    tryprint(fnames)

    flag = True
    for name in ['ok.txt', 'user_info.txt', 'acc_info.txt', 'bal_info.txt', 'tran_info.txt']:
        if name not in fnames:
            flag = False

    if not flag:
        continue

    tryprint('begin')

    # app_name = getfile('ok.txt') or '借转贷应用'
    app_name = '借转贷应用'
    app, _ = App.objects.get_or_create(name=app_name)
    project = app.project_set.create(name=str(timezone.now())[:19])

    try:
        os.remove(pjoin(WATCH_DIR, 'ok.txt'))
    except:
        pass

    tryprint(app, project)

    etl_step1(project)

    tryprint(5)









