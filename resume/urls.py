from django.conf.urls import url
from django.contrib.auth.views import logout

from . import views

app_name = 'resume'

urlpatterns = [
    url(r'^$', 'resume.views.index', name='index'),
]
