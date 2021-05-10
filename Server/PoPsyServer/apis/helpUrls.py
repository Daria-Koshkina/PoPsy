from django.urls import path
from apis.views import apiViews as views

urlpatterns = [

    path('getMusicPlayLists/', views.getMusicPlayLists)
]