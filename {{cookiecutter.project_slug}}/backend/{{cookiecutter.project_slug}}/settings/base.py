from .env import root, env

# Base dir refers to the root of Django application
BASE_DIR = root()

# Secret key is auto-generated when creating the cookie cutter
SECRET_KEY = env('SECRET_KEY')

# Debug should never be turned to True on production system !
DEBUG = env('DEBUG')

# Allowed host can be
ALLOWED_HOSTS = env('ALLOWED_HOSTS')
