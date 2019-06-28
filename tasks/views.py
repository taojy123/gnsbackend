import json

from django.http import JsonResponse
from django.shortcuts import render, get_object_or_404

from tasks.models import App, ETLTask, BuildingTask


def apps(request):
    rs = []
    for app in App.objects.order_by('id'):
        rs.append(app.serialize())
    return JsonResponse({'data': rs})


def etltasks(request):
    app_id = request.GET.get('app_id')
    name = request.GET.get('name')
    tasks = ETLTask.objects.order_by('-id')
    if app_id:
        tasks = tasks.filter(project__app__id=app_id)
    if name:
        tasks = tasks.filter(name=name)
    rs = []
    for task in tasks:
        rs.append(task.get_detail_serialization())
    return JsonResponse({'data': rs})


def buildingtasks(request):
    app_id = request.GET.get('app_id')
    name = request.GET.get('name')
    tasks = BuildingTask.objects.order_by('-id')
    if app_id:
        tasks = tasks.filter(project__app__id=app_id)
    if name:
        tasks = tasks.filter(name=name)
    rs = []
    for task in tasks:
        rs.append(task.get_detail_serialization())
    return JsonResponse({'data': rs})


def app_dir(request, app_id):
    app = get_object_or_404(App, id=app_id)
    if request.method == 'POST':
        data = json.loads(request.body)
        input_dir = data.get('input_dir')
        output_dir = data.get('output_dir')
        fake = data.get('fake', False)
        if input_dir:
            app.input_dir = input_dir
        if output_dir:
            app.output_dir = output_dir
        if not fake:
            app.save()
    r = {
        'input_dir': app.input_dir,
        'input_exists': app.input_exists,
        'output_dir': app.output_dir,
        'output_exists': app.output_exists,
    }
    return JsonResponse(r)

