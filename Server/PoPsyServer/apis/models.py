from django.db import models
from datetime import datetime


class Content(models.Model):
    title = models.CharField(max_length=200);
    status = models.CharField(max_length=200);

    def __str__(self):
        return self.title;


class User(models.Model):
    name = models.CharField(max_length=200);
    surname = models.CharField(max_length=200);
    photo = models.CharField(max_length=200, default='defaultphoto.png');
    email = models.CharField(max_length=200);
    phone = models.CharField(max_length=200, blank=True);
    age = models.IntegerField();
    password = models.CharField(max_length=200);

    def __str__(self):
        return self.name;


class Diary(models.Model):
    userId = models.IntegerField();

    def __str__(self):
        return self.id;


class Record(models.Model):
    diaryId = models.IntegerField();
    date = models.DateTimeField(default=datetime.now);
    type = models.CharField(max_length=200, default='text');
    content = models.CharField(max_length=1000);

    def __str__(self):
        return self.date;


class PremiumUser(models.Model):
    userId = models.IntegerField();
    endSubscription = models.DateTimeField(blank=True, null=True);

    def __str__(self):
        return self.userId;


class Psychologist(models.Model):
    name = models.CharField(max_length=200);
    info = models.CharField(max_length=1000);
    photo = models.CharField(max_length=200, default='defaultphoto.png');
    email = models.CharField(max_length=200);

    def __str__(self):
        return self.name;


class Consultation(models.Model):
    userId = models.IntegerField();
    psychologistId = models.IntegerField();
    date = models.DateTimeField(default=datetime.now);
    price = models.IntegerField();

    def __str__(self):
        return self.date;