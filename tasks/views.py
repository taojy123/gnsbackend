from django.http import JsonResponse
from django.shortcuts import render

from tasks.models import App, ETLTask, BuildingTask


def apps(requests):
    rs = []
    for app in App.objects.order_by('-id'):
        rs.append(app.serialize())
    return JsonResponse({'data': rs})


def etltasks(requests):
    rs = []
    for task in ETLTask.objects.order_by('-id'):
        rs.append(task.get_detail_serialization())
    return JsonResponse({'data': rs})


def buildingtasks(requests):
    rs = []
    for task in BuildingTask.objects.order_by('-id'):
        rs.append(task.get_detail_serialization())
    return JsonResponse({'data': rs})
