FROM python:3.6
ENV PYTHONUNBUFFERED 1

ADD requirements.pip /config/
RUN pip install -r /config/requirements.pip

ADD . /src
WORKDIR /src

RUN source bin/activate
RUN python manage.py migrate

CMD gunicorn openshift_django.wsgi -b 0.0.0.0:3013

EXPOSE 3013
