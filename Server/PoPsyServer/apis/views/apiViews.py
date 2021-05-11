from rest_framework import generics
from django.http import HttpResponse, JsonResponse, HttpResponseBadRequest
from .. import models, helpModels
import jsonpickle
import json
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
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

def register(request):
    email = request.POST.get("email")
    password = request.POST.get("password")
    if models.User.objects.get(email=email).DoesNotExist:
        user = models.User()
        user.email = email
        user.password = password
        user.save()
        return HttpResponse()
    else:
        return HttpResponseBadRequest()

def singIn(request):
    email = request.POST.get("email")
    password = request.POST.get("password")
    if models.User.objects.get(email=email).DoesNotExist:
        return HttpResponseBadRequest()
    else:
        user = models.User.objects.get(email=email)
        if user.password == password:
            user_exp = helpModels.User_exp()
            user_exp.name = user.name
            user_exp.surname = user.surname
            user_exp.email = user.email
            user_exp.password = user.password
            user_exp.age = user.age
            user_exp.phone = user.phone
            user_exp.photo = user.photo
            return JsonResponse(jsonpickle.decode(jsonpickle.encode(user_exp,unpicklable=False)),safe = False)