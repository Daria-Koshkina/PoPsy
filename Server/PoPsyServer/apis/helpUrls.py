from django.urls import path
from apis.views import apiViews as views

urlpatterns = [
    path('getContent/', views.getContent),
    path('register/', views.register),
    path('signIn/', views.singIn),
    path('getUser/', views.getUser),
    path('getUserById/', views.getUserByEmail),
    path('allTests/', views.allTests),
    path('getCategories/', views.getCategories),
    path('usedTests/', views.usedTests),
    path('prepareSession/', views.prepareSession),
    path('postTestResult/', views.postTestResult),
    path('prepareDiary/', views.prepareDiary),
    path('postRecord/', views.postRecord),
]