from rest_framework import serializers
from apis import models


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'name',
            'surname',
            'photo',
            'email',
            'phone',
            'age',
            'password'
        )
        model = models.User


class AudioSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'title',
            'author',
            'image',
            'time',
            'url'
        )
        model = models.Audio


class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'title',
            'author',
            'image',
            'time',
            'url'
        )
        model = models.Video


class AudioListSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'image',
            'title'
        )
        model = models.AudioList


class VideoListSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'image',
            'title'
        )
        model = models.VideoList


class AudioHasAudioListSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'audioId',
            'audioListId'
        )
        model = models.AudioHasAudioList


class VideoHasVideoListSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'videoId',
            'videoListId'
        )
        model = models.VideoHasVideoList


class AudioListViewSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'userId',
            'audioListId',
            'date'
        )
        model = models.AudioListView


class VideoListViewSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'userId',
            'videoListId',
            'date'
        )
        model = models.VideoListView


class ArticleViewSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'userId',
            'articleId',
            'date'
        )
        model = models.ArticleView


class NotificationViewSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'userId',
            'notificationId',
            'date'
        )
        model = models.NotificationView


class ArticleSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'title',
            'content',
            'author'
        )
        model = models.Article


class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'title',
            'text',
            'link'
        )
        model = models.Notification


class UserEmotionsSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'userId',
            'empty',
            'sadness',
            'enthusiasm',
            'worry',
            'surprise',
            'love',
            'fun',
            'hate',
            'happiness',
            'boredom',
            'relief',
            'anger'
        )
        model = models.UserEmotions



