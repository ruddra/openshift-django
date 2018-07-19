#!/bin/bash
pip install -r requirements.pip
python manage.py makemigrations
python manage.py migrate