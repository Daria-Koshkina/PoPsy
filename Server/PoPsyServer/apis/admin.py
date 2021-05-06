from django.contrib import admin
from .models import User, Diary, Record, PremiumUser, Psychologist, Content, Consultation

admin.site.register(User)
admin.site.register(Diary)
admin.site.register(Record)
admin.site.register(PremiumUser)
admin.site.register(Psychologist)
admin.site.register(Content)
admin.site.register(Consultation)