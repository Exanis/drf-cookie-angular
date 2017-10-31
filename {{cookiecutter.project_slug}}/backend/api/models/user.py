from uuid import uuid4
from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    uuid = models.UUIDField(primary_key=True, editable=False, default=uuid4)
    
    class Meta(object):
        permissions = (
            ('view_user', 'View user',),
        )
        default_related_name = 'users'
