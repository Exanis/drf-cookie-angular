from django.test.runner import DiscoverRunner
from django.test.testcases import TestCase
from rest_framework.test import APIClient


def before_all(context):
    context.test_runner = DiscoverRunner()
    context.test_runner.setup_test_environment()
    context.old_db_config = context.test_runner.setup_databases()
    context.apiClient = APIClient()


def after_all(context):
    context.test_runner.teardown_databases(context.old_db_config)
    context.test_runner.teardown_test_environment()


def before_scenario(context, _):
    context.test = TestCase()
    context.test.setUpClass()


def after_scenario(context, _):
    context.test.tearDownClass()
    context.apiClient.logout()
    del context.test
