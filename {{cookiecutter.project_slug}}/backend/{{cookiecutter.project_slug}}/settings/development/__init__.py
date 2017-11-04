from ..base import *
from ..i18n import *
from .services import *
from ..static import *

# Add django extensions to app here to avoid using it in production
INSTALLED_APPS += ('django_extensions',)
