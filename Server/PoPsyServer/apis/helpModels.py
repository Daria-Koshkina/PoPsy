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