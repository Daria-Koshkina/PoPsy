from django.urls import path
from apis import views

urlpatterns = [
    path('', views.ListUser.as_view()),
    path('<int:pk>/', views.DetailUser.as_view())
]