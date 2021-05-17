import json
from json import JSONEncoder
from datetime import datetime


class Question:
    text = ''
    photo = ''
    variants = []

class Variant:
    text = ''
    weight = 0

class Category:
    text = ''

class Scores:
    score = []

class Score:
    start = 0
    end = 0
    text = ''

class TestResult:
    result = ''
    date = ''
    photo = ''
class TestSession:
    id = 0
    Sessions = []
class Test:
    id = 0
    title = ''
    description = ''
    photo = ''
    questions = []
    categories = []
    scores = Scores()

class Music:
    title = ''
    author = ''
    image = ''
    time = ''
    url = ''

class Video:
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
    id = 0
    name = ''
    surname = ''
    photo = ''
    email = ''
    phone = ''
    age = 0
    password = ''

