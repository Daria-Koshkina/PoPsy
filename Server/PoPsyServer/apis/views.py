from django.shortcuts import render
from apis import models
from apis import serializers
from rest_framework import generics


class ListUser(generics.ListCreateAPIView):
    queryset = models.User.objects.all()
    serializer_class = serializers.UserSerializer


class DetailUser(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.User.objects.all()
    serializer_class = serializers.UserSerializer


class ListVideo(generics.ListCreateAPIView):
    queryset = models.Video.objects.all()
    serializer_class = serializers.VideoSerializer


class DetailVideo(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Video.objects.all()
    serializer_class = serializers.VideoSerializer


class ListAudio(generics.ListCreateAPIView):
    queryset = models.Audio.objects.all()
    serializer_class = serializers.AudioSerializer


class DetailAudio(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Audio.objects.all()
    serializer_class = serializers.AudioSerializer


class ListAudioList(generics.ListCreateAPIView):
    queryset = models.AudioList.objects.all()
    serializer_class = serializers.AudioListSerializer


class DetailAudioList(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.AudioList.objects.all()
    serializer_class = serializers.AudioListSerializer


class ListVideoList(generics.ListCreateAPIView):
    queryset = models.VideoList.objects.all()
    serializer_class = serializers.VideoListSerializer


class DetailVideoList(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.VideoList.objects.all()
    serializer_class = serializers.VideoListSerializer


class ListAudioHasAudioList(generics.ListCreateAPIView):
    queryset = models.AudioHasAudioList.objects.all()
    serializer_class = serializers.AudioHasAudioListSerializer


class DetailAudioHasAudioList(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.AudioHasAudioList.objects.all()
    serializer_class = serializers.AudioHasAudioListSerializer


class ListVideoHasVideoList(generics.ListCreateAPIView):
    queryset = models.VideoHasVideoList.objects.all()
    serializer_class = serializers.VideoHasVideoListSerializer


class DetailVideoHasVideoList(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.VideoHasVideoList.objects.all()
    serializer_class = serializers.VideoHasVideoListSerializer


class ListAudioListView(generics.ListCreateAPIView):
    queryset = models.AudioListView.objects.all()
    serializer_class = serializers.AudioListViewSerializer


class DetailAudioListView(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.AudioListView.objects.all()
    serializer_class = serializers.AudioListViewSerializer


class ListVideoListView(generics.ListCreateAPIView):
    queryset = models.VideoListView.objects.all()
    serializer_class = serializers.VideoListViewSerializer


class DetailVideoListView(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.VideoListView.objects.all()
    serializer_class = serializers.VideoListViewSerializer


class ListArticleView(generics.ListCreateAPIView):
    queryset = models.ArticleView.objects.all()
    serializer_class = serializers.ArticleViewSerializer


class DetailArticleView(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.ArticleView.objects.all()
    serializer_class = serializers.ArticleViewSerializer


class ListNotificationView(generics.ListCreateAPIView):
    queryset = models.NotificationView.objects.all()
    serializer_class = serializers.NotificationViewSerializer


class DetailNotificationView(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.NotificationView.objects.all()
    serializer_class = serializers.NotificationViewSerializer


class ListArticle(generics.ListCreateAPIView):
    queryset = models.Article.objects.all()
    serializer_class = serializers.ArticleSerializer


class DetailArticle(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Article.objects.all()
    serializer_class = serializers.ArticleSerializer


class ListNotification(generics.ListCreateAPIView):
    queryset = models.Notification.objects.all()
    serializer_class = serializers.NotificationSerializer


class DetailNotification(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Notification.objects.all()
    serializer_class = serializers.NotificationSerializer
