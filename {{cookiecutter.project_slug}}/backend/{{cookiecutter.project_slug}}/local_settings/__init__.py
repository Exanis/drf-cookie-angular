"""
Import most of settings except for services ones

Allow an easier local configuration
"""

# pylint: skip-file

from {{cookiecutter.project_slug}}.settings.base import *
from {{cookiecutter.project_slug}}.settings.i18n import *
from {{cookiecutter.project_slug}}.settings.static import *
from .services import *
