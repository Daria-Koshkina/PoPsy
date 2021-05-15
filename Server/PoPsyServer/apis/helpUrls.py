from django.urls import path
from apis.views import apiViews as views

urlpatterns = [
    path('getContent/', views.getContent),
    path('register/', views.register),
    path('signIn/', views.singIn)
]