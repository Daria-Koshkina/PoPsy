from django.db import models
from datetime import datetime


class User(models.Model):
    name = models.CharField(max_length=200)
    surname = models.CharField(max_length=200)
    photo = models.CharField(max_length=200, default='defaultphoto.png')
    email = models.CharField(max_length=200)
    phone = models.CharField(max_length=200, blank=True, null=True)
    age = models.IntegerField(blank=True, null=True)
    password = models.CharField(max_length=200)

    def __str__(self):
        return self.name


class Diary(models.Model):
    userId = models.IntegerField()

    def __str__(self):
        return str(self.id)


class Record(models.Model):
    diaryId = models.IntegerField()
    date = models.DateTimeField(default=datetime.now)
    type = models.CharField(max_length=200, default='text')
    content = models.CharField(max_length=1000)

    def __str__(self):
        return str(self.date)


class PremiumUser(models.Model):
    userId = models.IntegerField()
    endSubscription = models.DateTimeField(blank=True, null=True)

    def __str__(self):
        return str(self.userId)


class Psychologist(models.Model):
    name = models.CharField(max_length=200)
    info = models.CharField(max_length=1000)
    photo = models.CharField(max_length=200, default='defaultphoto.png')
    email = models.CharField(max_length=200)

    def __str__(self):
        return self.name


class Consultation(models.Model):
    userId = models.IntegerField()
    psychologistId = models.IntegerField()
    date = models.DateTimeField(default=datetime.now)
    price = models.IntegerField()

    def __str__(self):
        return str(self.date)


class TestResult(models.Model):
    testId = models.IntegerField()
    userId = models.IntegerField()
    result = models.CharField(max_length=200)
    date = models.DateTimeField()
    photo = models.CharField(max_length=200, default='defaultphoto.png')

    def __str__(self):
        return self.result


class Test(models.Model):
    title = models.CharField(max_length=200)
    photo = models.CharField(max_length=200, default='defaultphoto.png')

    def __str__(self):
        return self.title


class TestHasCategories(models.Model):
    testId = models.IntegerField()
    categotyId = models.IntegerField()

    def __str__(self):
        return str(self.testId)


class Category(models.Model):
    title = models.CharField(max_length=200)

    def __str__(self):
        return self.title


class Question(models.Model):
    testId = models.IntegerField()
    text = models.CharField(max_length=200)
    photo = models.CharField(max_length=200, default='defaultphoto.png')

    def __str__(self):
        return self.text


class Variant(models.Model):
    questionId = models.IntegerField()
    text = models.CharField(max_length=200)
    weight = models.FloatField()

    def __str__(self):
        return self.text

class Score(models.Model):
    testId = models.IntegerField()
    start = models.FloatField()
    end = models.FloatField()
    text = models.CharField(max_length=200)

    def __str__(self):
        return self.text

class ArticleView(models.Model):
    userId = models.IntegerField()
    articleId = models.IntegerField()
    date = models.DateTimeField(default=datetime.now)

    def __str__(self):
        return str(self.articleId)


class VideoListView(models.Model):
    userId = models.IntegerField()
    videoListId = models.IntegerField()
    date = models.DateTimeField(default=datetime.now)

    def __str__(self):
        return str(self.videoListId)


class AudioListView(models.Model):
    userId = models.IntegerField()
    audioListId = models.IntegerField()
    date = models.DateTimeField(default=datetime.now)

    def __str__(self):
        return str(self.audioListId)


class NotificationView(models.Model):
    userId = models.IntegerField()
    notificationId = models.IntegerField()
    date = models.DateTimeField(default=datetime.now)

    def __str__(self):
        return str(self.notificationId)


class Article(models.Model):
    title = models.CharField(max_length=200)
    content = models.CharField(max_length=200)
    author = models.CharField(max_length=200)

    def __str__(self):
        return self.title


class Notification(models.Model):
    title = models.CharField(max_length=200)
    text = models.CharField(max_length=200)
    link = models.CharField(max_length=200)

    def __str__(self):
        return self.title


class AudioList(models.Model):
    title = models.CharField(max_length=200)
    image = models.CharField(max_length=200)

    def __str__(self):
        return self.title


class VideoList(models.Model):
    title = models.CharField(max_length=200)
    image = models.CharField(max_length=200)

    def __str__(self):
        return self.title


class Video(models.Model):
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=200)
    image = models.CharField(max_length=200)
    time = models.CharField(max_length=200)
    url = models.CharField(max_length=200)

    def __str__(self):
        return self.title


class Audio(models.Model):
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=200)
    image = models.CharField(max_length=200)
    time = models.CharField(max_length=200)
    url = models.CharField(max_length=200)

    def __str__(self):
        return self.title


class VideoHasVideoList(models.Model):
    videoId = models.IntegerField()
    videoListId = models.IntegerField()

    def __str__(self):
        return str(self.videoId)


class AudioHasAudioList(models.Model):
    audioId = models.IntegerField()
    audioListId = models.IntegerField()

    def __str__(self):
        return str(self.audioId)


class UserEmotions(models.Model):
    userId = models.IntegerField()
    sadness = models.FloatField()
    worry = models.FloatField()
    love = models.FloatField()
    hate = models.FloatField()
    happiness = models.FloatField()

    def __str__(self):
        return str(self.userId)