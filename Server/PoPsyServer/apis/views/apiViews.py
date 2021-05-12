from rest_framework import generics
from django.http import HttpResponse, JsonResponse, HttpResponseBadRequest
from .. import models, helpModels
import jsonpickle
import json
from django.views.decorators.csrf import csrf_exempt
from apis.AI.Recomedation import  Rcomendaror
import numpy as np


def UserEmotionToList(userEmotion:models.UserEmotions):
    emotions = []
    emotions.append(userEmotion.userId)
    emotions.append(userEmotion.empty)
    emotions.append(userEmotion.sadness)
    emotions.append(userEmotion.enthusiasm)
    emotions.append(userEmotion.worry)
    emotions.append(userEmotion.surprise)
    emotions.append(userEmotion.love)
    emotions.append(userEmotion.fun)
    emotions.append(userEmotion.hate)
    emotions.append(userEmotion.happiness)
    emotions.append(userEmotion.boredom)
    emotions.append(userEmotion.relief)
    emotions.append(userEmotion.anger)
    return  emotions

def ContentToList(content):
    return content.id

def AudioListViewToList(audioList:models.AudioListView):
    return audioList.audioListId

def VideoListViewToList(videoListView:models.VideoListView):
    return videoListView.videoListId

def ArticleViewToList(articleView:models.ArticleView):
    return articleView.articleId

def PrepareContent(userId):
    recomendator = Rcomendaror()
    currentUserEmotions = UserEmotionToList(models.UserEmotions.objects.filter(userId=userId).first())
    otherUserEmotions = [UserEmotionToList(i) for i in models.UserEmotions.objects.all()]
    nearestUserEmotion = recomendator.get_nearest(currentUserEmotions, otherUserEmotions)
    playlists = [ContentToList(i) for i in models.AudioList.objects.all()]
    videolists = [ContentToList(i) for i in models.VideoList.objects.all()]
    articles = [ContentToList(i) for i in models.Article.objects.all()]
    playlistsView = [AudioListViewToList(i) for i in models.AudioListView.objects.filter(userId=nearestUserEmotion)]
    videolistsView = [VideoListViewToList(i) for i in models.VideoListView.objects.filter(userId=nearestUserEmotion)]
    articlesView = [ArticleViewToList(i) for i in models.ArticleView.objects.filter(userId=nearestUserEmotion)]
    audioRecomndations, videoRecomendations, articleRecomendations = recomendator.generate_recomendations(playlists, videolists, articles, playlistsView, videolistsView, articlesView)
    audios = [models.AudioList.objects.filter(id=i).first() for i in audioRecomndations]
    videos = [models.VideoList.objects.filter(id=i).first() for i in videoRecomendations]
    articles = [models.Article.objects.filter(id=i).first() for i in articleRecomendations]
    return audios, videos, articles

@csrf_exempt
def getContent(request):
    currentUserId = int(request.POST.get("userId"))
    audios, videos, articles = PrepareContent(currentUserId)

    musiclists = []
    for audiolist in audios:
        musiclist = helpModels.MusicPlaylist()
        musiclist.title = audiolist.title
        musiclist.image = audiolist.image
        musiclist.status = 'Songs'
        musiclist.songs = []
        songconnecters = models.AudioHasAudioList.objects.filter(audioListId=audiolist.id)
        for songconnecter in songconnecters:
            audio = models.Audio.objects.filter(id=songconnecter.audioId).first()
            song = helpModels.Music()
            song.title = audio.title
            song.image = audio.image
            song.author = audio.author
            song.time = audio.time
            song.url = audio.url
            musiclist.songs.append(song)
        musiclists.append(musiclist)

    videolists = []
    for videolist in videos:
        videolist_exp = helpModels.VideoPlayList()
        videolist_exp.title = videolist.title
        videolist_exp.image = videolist.image
        videolist_exp.status = 'Videos'
        videolist_exp.videos = []
        videoconnecters = models.VideoHasVideoList.objects.filter(videoListId=videolist.id)
        for videoconnecter in videoconnecters:
            video = models.Video.objects.filter(id=videoconnecter.videoId).first()
            video_exp = helpModels.Video()
            video_exp.title = video.title
            video_exp.image = video.image
            video_exp.author = video.author
            video_exp.time = video.time
            video_exp.url = video.url
            videolist_exp.videos.append(video_exp)
        videolists.append(videolist_exp)

    articles_exp = []
    for article in articles:
        article_exp = helpModels.Article_exp()
        article_exp.title = article.title
        article_exp.author = article.author
        article_exp.text = article.content
        article_exp.status = 'Article'
        articles_exp.append(article_exp)

    content = musiclists + videolists + articles_exp
    content = np.array(content)
    np.random.shuffle(content)
    content = content.tolist()
    return JsonResponse(jsonpickle.decode(jsonpickle.encode(list(content),unpicklable=False)),safe = False)




def getMusicPlayLists(request):
    musiclists = []
    playlists = models.AudioList.objects.all()
    for playlist in playlists:
        musiclist = helpModels.MusicPlaylist()
        musiclist.title = playlist.title
        musiclist.image = playlist.image
        musiclist.status = 'Songs'
        musiclist.songs = []
        songconnecters = models.AudioHasAudioList.objects.filter(audioListId=playlist.id)
        for songconnecter in songconnecters:
            audio = models.Audio.objects.filter(id=songconnecter.audioId).first()
            song = helpModels.Music()
            song.title = audio.title
            song.image = audio.image
            song.author = audio.author
            song.time = audio.time
            song.url = audio.url
            musiclist.songs.append(song)
        musiclists.append(musiclist)

    return JsonResponse(jsonpickle.decode(jsonpickle.encode(list(musiclists),unpicklable=False)),safe = False)

@csrf_exempt
def register(request):
    name = request.POST.get("name")
    surname = request.POST.get("surname")
    image = request.POST.get("image")
    email = request.POST.get("email")
    phone = request.POST.get("phone")
    age = request.POST.get("age")
    password = request.POST.get("password")
    if models.User.objects.filter(email=email).exists():
        return HttpResponseBadRequest()
    else:
        user = models.User()
        user.name = name
        user.surname = surname
        user.photo = image
        user.email = email
        user.phone = phone
        user.age = age
        user.password = password
        user.save()
        return HttpResponse()

@csrf_exempt
def singIn(request):
    email = request.POST.get("email")
    password = request.POST.get("password")
    if models.User.objects.filter(email=email).exists():
        user = models.User.objects.get(email=email)
        if user.password == password:
            user_exp = helpModels.User_exp()
            user_exp.id = user.id
            user_exp.name = user.name
            user_exp.surname = user.surname
            user_exp.email = user.email
            user_exp.password = user.password
            user_exp.age = user.age
            user_exp.phone = user.phone
            user_exp.photo = user.photo
            return JsonResponse(jsonpickle.decode(jsonpickle.encode(user_exp,unpicklable=False)),safe = False)
    else:
        return HttpResponseBadRequest()