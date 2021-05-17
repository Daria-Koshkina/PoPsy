from django.http import HttpResponse, JsonResponse, HttpResponseBadRequest
from .. import models, helpModels
import jsonpickle
from django.views.decorators.csrf import csrf_exempt
import numpy as np
import requests
from apis.views import urlStrings
from datetime import datetime


def UserEmotionToList(userEmotion:models.UserEmotions):
    emotions = []
    emotions.append(userEmotion.userId)
    emotions.append(userEmotion.sadness)
    emotions.append(userEmotion.worry)
    emotions.append(userEmotion.love)
    emotions.append(userEmotion.hate)
    emotions.append(userEmotion.happiness)
    return  emotions

def ContentToList(content):
    return content.id

def AudioListViewToList(audioList:models.AudioListView):
    return audioList.audioListId

def VideoListViewToList(videoListView:models.VideoListView):
    return videoListView.videoListId

def ArticleViewToList(articleView:models.ArticleView):
    return articleView.articleId

def PrepareTests(testsQ):

    tests = []
    for i in testsQ:
        test = helpModels.Test()
        test.id = i.id
        test.title = i.title
        test.description = i.description
        test.photo = i.photo
        questionsQ= models.Question.objects.filter(testId=i.id)
        questions_exp = []
        for j in questionsQ:
            question = helpModels.Question()
            question.photo = j.photo
            question.text = j.text
            variantsQ= models.Variant.objects.filter(questionId=j.id)
            variants_exp = []
            for k in variantsQ:
                variant = helpModels.Variant()
                variant.text = k.text
                variant.weight = k.weight
                variants_exp.append(variant)
            question.variants = jsonpickle.decode(jsonpickle.encode(list(variants_exp), unpicklable=False))
            questions_exp.append(question)
        categories = models.TestHasCategories.objects.filter(testId=i.id)
        categories_exp = []
        for j in categories:
            category = models.Category.objects.filter(id=j.categotyId).first()
            cat = helpModels.Category()
            cat.text = category.title
            categories_exp.append(cat)
        scores = models.Score.objects.filter(testId=i.id)
        sc = helpModels.Scores()
        scores_exp = []
        for j in scores:
            score = helpModels.Score()
            score.text = j.text
            score.start = j.start
            score.end = j.end
            scores_exp.append(score)
        sc.score = jsonpickle.decode(jsonpickle.encode(list(scores_exp), unpicklable=False))
        test.scores = sc
        test.categories = jsonpickle.decode(jsonpickle.encode(list(categories_exp), unpicklable=False))
        test.questions = jsonpickle.decode(jsonpickle.encode(list(questions_exp), unpicklable=False))
        tests.append(test)
    return tests

@csrf_exempt
def prepareDiary(request):
    currentUserId = int(request.POST.get("userId"))
    diary = models.Diary.objects.filter(userId=currentUserId).first()
    records = []
    recordsQ = models.Record.objects.filter(diaryId = diary.id)
    for i in recordsQ:
        record = helpModels.Record()
        record.content = i.content
        record.Date = i.date
        record.type = i.type
        records.append(record)
    d = helpModels.Diary()
    d.records = records;
    return JsonResponse(jsonpickle.decode(jsonpickle.encode(d, unpicklable=False)), safe=False)

@csrf_exempt
def allTests(request):
    categories= request.POST.get("categories")
    if categories == '[]':
        testsQ = models.Test.objects.all()
    else:
        categories = jsonpickle.decode(categories)
        categoryTitles = []
        for category in categories:
            categoryTitles.append(category['title'])
        categories = models.Category.objects.filter(title__in=categoryTitles)
        categoryIds = []
        for category in categories:
            categoryIds.append(category.id)
        category_tests = models.TestHasCategories.objects.filter(categotyId__in=categoryIds)
        testIds = []
        for category_test in category_tests:
            idc = category_test.testId
            if idc not in testIds:
                testIds.append(idc)
        testsQ = models.Test.objects.filter(id__in=testIds)
    tests = PrepareTests(testsQ)
    jasonstr = jsonpickle.decode(jsonpickle.encode(list(tests), unpicklable=False))
    return JsonResponse(jasonstr, safe=False)

@csrf_exempt
def getCategories(request):
    categories_exp = []
    categories = models.Category.objects.all()
    for j in categories:
        cat = helpModels.Category()
        cat.text = j.title
        categories_exp.append(cat)
    return JsonResponse(jsonpickle.decode(jsonpickle.encode(list(categories_exp), unpicklable=False)), safe=False)


@csrf_exempt
def usedTests(request):
    currentUserId = int(request.POST.get("userId"))
    testsResQ = models.TestResult.objects.filter(userId=currentUserId)
    testsQ  = [models.Test.objects.filter(id=i.testId).first() for i in testsResQ]
    tests = PrepareTests(testsQ)
    return JsonResponse(jsonpickle.decode(jsonpickle.encode(list(tests), unpicklable=False)), safe=False)


@csrf_exempt
def prepareSession(request):
    currentUserId = int(request.POST.get("userId"))
    sessionsQ = models.TestResult.objects.filter(userId=currentUserId)
    session = []
    used = []
    for i in sessionsQ:
        res = helpModels.TestResult()
        res.result = i.result
        res.date = i.date
        res.photo = i.photo

        if not i.testId in used:
            ses = helpModels.TestSession()
            used.append(i.testId)
            ses.id = i.testId
            ses.Sessions.append(res)
            ses.Sessions = jsonpickle.decode(jsonpickle.encode(list(ses.Sessions), unpicklable=False))
            session.append(ses)
        else:
            session[used.index(i.testId)].Sessions.append(res)
    return JsonResponse(jsonpickle.decode(jsonpickle.encode(list(session), unpicklable=False)), safe=False)


@csrf_exempt
def postTestResult(request):
    testResult = models.TestResult()
    testResult.testId = int(request.POST.get("testId"))
    testResult.userId = int(request.POST.get("userId"))
    testResult.date = datetime.strptime(request.POST.get("testResult")["date"],'%y-%m-YdT%H:%M:%S%z')
    testResult.result = request.POST.get("testResult")["result"]
    testResult.image = request.POST.get("testResult")["image"]
    testResult.save()
    return HttpResponse()


def PrepareContent(userId):
    currentUserEmotions = UserEmotionToList(models.UserEmotions.objects.filter(userId=userId).first())
    otherUserEmotions = [UserEmotionToList(i) for i in models.UserEmotions.objects.all()]

    responce = requests.post(urlStrings.nearestUserEmotion, {"currentUserEmotions" : jsonpickle.encode(currentUserEmotions), "otherUserEmotions" : jsonpickle.encode(otherUserEmotions)})
    nearestUserEmotion = jsonpickle.decode(jsonpickle.decode(responce.content.decode('utf-8')))

    playlists = [ContentToList(i) for i in models.AudioList.objects.all()]
    videolists = [ContentToList(i) for i in models.VideoList.objects.all()]
    articles = [ContentToList(i) for i in models.Article.objects.all()]

    playlistsView = [AudioListViewToList(i) for i in models.AudioListView.objects.filter(userId=nearestUserEmotion)]
    videolistsView = [VideoListViewToList(i) for i in models.VideoListView.objects.filter(userId=nearestUserEmotion)]
    articlesView = [ArticleViewToList(i) for i in models.ArticleView.objects.filter(userId=nearestUserEmotion)]

    responce = requests.post(urlStrings.generateRecomendations,
                             {"playlists": jsonpickle.encode(playlists),
                              "videolists": jsonpickle.encode(videolists),
                              "articles": jsonpickle.encode(articles),
                              "playlistsView": jsonpickle.encode(playlistsView),
                              "videolistsView": jsonpickle.encode(videolistsView),
                              "articlesView": jsonpickle.encode(articlesView)})
    map = responce.content.decode('utf-8')
    map = jsonpickle.decode(map)
    audioRecomndations = jsonpickle.decode(map["audioRecomndations"])
    videoRecomendations = jsonpickle.decode(map["videoRecomendations"])
    articleRecomendations = jsonpickle.decode(map["articleRecomendations"])
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


@csrf_exempt
def register(request):
    name = request.POST.get("name")
    surname = request.POST.get("surname")
    image = request.POST.get("image")
    email = request.POST.get("email")
    phone = request.POST.get("phone")
    age = request.POST.get("age")
    if age != 'null':
        age = int(age)
    else:
        age = None
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
        useremotions = models.UserEmotions()
        useremotions.userId = user.id
        useremotions.empty = 0
        useremotions.sadness = 0
        useremotions.enthusiasm = 0
        useremotions.worry = 0
        useremotions.surprise = 0
        useremotions.love = 0
        useremotions.fun = 0
        useremotions.hate = 0
        useremotions.happiness = 0
        useremotions.boredom = 0
        useremotions.relief = 0
        useremotions.anger = 0
        useremotions.save()
        return JsonResponse(jsonpickle.decode(jsonpickle.encode(user.id, unpicklable=False)), safe=False)


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


@csrf_exempt
def getUser(request):
    userId = request.POST.get("userId")
    userId = int(userId)
    if models.User.objects.filter(id=userId).exists():
        user = models.User.objects.get(id=userId)
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

@csrf_exempt
def getUserByEmail(request):
    email = request.POST.get("email")
    if models.User.objects.filter(email=email).exists():
        user = models.User.objects.get(email=email)
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