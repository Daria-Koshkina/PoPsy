from rest_framework import serializers
from apis import models


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'name',
            'surname',
            'photo',
            'email',
            'phone',
            'age',
            'password'
        )
        model=models.User