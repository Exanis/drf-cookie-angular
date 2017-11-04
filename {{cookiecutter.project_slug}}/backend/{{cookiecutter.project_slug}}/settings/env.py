"""
Initialize environment for {{cookiecutter.project_slug}}

This file is usually the core of most other settings files
"""

import environ

root = environ.Path(__file__) - 3
env = environ.Env(
    DEBUG=(bool, False),
    SECRET_KEY=(str, 'Testing secret key'),
    ALLOWED_HOSTS=(list, []),
    LANGUAGE_CODE=(str, 'fr-FR'),
    TIME_ZONE=(str, 'Europe/Paris'),
    REDIS_URL=(str, 'redis://redis:6379')
)
environ.Env.read_env()
