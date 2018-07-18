FROM python:3.6
ENV PYTHONUNBUFFERED 1

ADD requirements.pip /config/
RUN pip install -r /config/requirements.pip

ADD . /src
WORKDIR /src
RUN chmod u+x run-build.sh
RUN chmod u+x run-test.sh
RUN chmod u+x run-sonarqube.sh
RUN ./run-build.sh
RUN ./run-test.sh
RUN ./run-sonarqube.sh

CMD gunicorn openshift_django.wsgi -b 0.0.0.0:3013
# CMD python manage.py runserver 0.0.0.0:3013

EXPOSE 3013
