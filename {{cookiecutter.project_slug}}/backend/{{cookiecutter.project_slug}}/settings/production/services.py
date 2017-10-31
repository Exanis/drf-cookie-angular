"""
External services (database, cache...)
"""
from {{cookiecutter.project_slug}}.settings.env import env

DATABASES = {
    'default': env.db()
}

CACHES = env.cache()
