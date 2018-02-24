FROM python:3.6
ENV PYTHONUNBUFFERED 1

ADD requirements.pip /config/
RUN pip install -r /config/requirements.pip

RUN mkdir /src
WORKDIR /src
ADD . /src
RUN ./manage.py makemigrations
RUN ./manage.py migrate
RUN ./manage.py collectstatic --no-input

CMD gunicorn openshift_django.wsgi -b 3013
# CMD python manage.py runserver 0.0.0.0:3013

EXPOSE 3013
