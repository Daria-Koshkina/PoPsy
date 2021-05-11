import json
from json import JSONEncoder

class Music:
    title = ''
    author = ''
    image = ''
    time = ''
    url = ''

class Content:
    title = ''
    status = ''

class MusicPlaylist(Content):
    songs = []
    image = ''

class VideoPlayList(Content):
    videos = []
    image = ''

class Notification_exp(Content):
    text = ''
    url = ''

class Article_exp(Content):
    text = ''
    author = ''

class User_exp:
    name = ''
    surname = ''
    photo = ''
    email = ''
    phone = ''
    age = 0
    password = ''

