from django.test import TestCase
from django.contrib.auth import get_user_model
from django.db.models import UUIDField
from api import models


class UserTest(TestCase):
    def test_uuid_is_pk(self):
        model = models.User
        self.assertIs(model.pk, model.uuid)

    def test_have_uuid(self):
        model = models.User
        try:
            self.assertIsNotNone(model.uuid)
        except AttributeError:
            self.fail("Model user should contain an uuid")

    def test_is_default_model(self):
        model = get_user_model()
        self.assertIs(model, models.User)
