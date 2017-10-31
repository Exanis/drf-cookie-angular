"""
Localization-related settings
"""
from .env import env

LANGUAGE_CODE = env('LANGUAGE_CODE')
TIME_ZONE = env('TIME_ZONE')

USE_I18N = True
USE_L10N = True
USE_TZ = True
