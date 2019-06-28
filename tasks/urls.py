#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-06-08 16:39
# @Author  : Jinpin Hong
from django.urls import path

from tasks import views

urlpatterns = [
    path('apps/', views.apps),
    path('etltasks/', views.etltasks),
    path('buildingtasks/', views.buildingtasks),
    path('apps/<int:app_id>/dir/', views.app_dir),
]
