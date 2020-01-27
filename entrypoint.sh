#!/bin/sh

pipenv run python manage.py migrate todo
pipenv run python manage.py runserver 0.0.0.0:8080