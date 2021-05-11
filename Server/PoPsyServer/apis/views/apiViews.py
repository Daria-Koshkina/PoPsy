from rest_framework import generics
from django.http import HttpResponse, JsonResponse
from .. import models, helpModels
import jsonpickle
import json


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
