"""{{cookiecutter.project_slug}} URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.conf.urls import url, include

urlpatterns = [
    url(r'^api/1.0/', include('api.urls')),

    url(r'^api/1.0/tools/jet/', include('jet.urls', 'jet')),  # Django JET URLS
    url(
        r'^api/1.0/tools/jet/dashboard/',
        include('jet.dashboard.urls', 'jet-dashboard')
    ),

    url(
        r'^api/1.0/api-auth/',
        include('rest_framework.urls', namespace='rest_framework')
    ),

    url(r'^api/1.0/tools/admin/', include(admin.site.urls)),
    url(r'^api/1.0/tools/silk/', include('silk.urls', namespace='silk')),
]
