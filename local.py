# Overrides
from .settings import *  # noqa: F401
import os

ALLOWED_HOSTS = ['*']
DEBUG = True

SECRET_KEY = os.environ['SECRET_KEY']

DEBUG = True

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ['DATABASE_NAME'],
        'HOST': os.environ['DATABASE_HOST'],
        'USER': os.environ['DATABASE_USER'],
        'PASSWORD': os.environ['DATABASE_PASSWORD'],
        # 'PORT': int(os.environ['DATABASE_PORT']),
        # 'USER': 'django',
        # 'PASSWORD': '123Asd123',
        'PORT': '',
    },
}

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

# TODO-specific settings
TODO_STAFF_ONLY = False
TODO_DEFAULT_LIST_SLUG = 'tickets'
TODO_DEFAULT_ASSIGNEE = None
TODO_PUBLIC_SUBMIT_REDIRECT = '/'
