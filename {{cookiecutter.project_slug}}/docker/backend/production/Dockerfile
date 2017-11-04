FROM python:3.6.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/backend/requirements
RUN mkdir -p /usr/src/backend/src
WORKDIR /usr/src/backend

COPY src/requirements/ ./requirements/
RUN pip install -U pip
RUN pip install -r requirements/production.txt

WORKDIR /usr/src/backend/src
COPY src/ ./
RUN rm -rf requirements \
    requirements.txt \
    {{cookiecutter.project_slug}}/settings/local \
    test.sh

EXPOSE 8000
CMD python manage.py migrate && gunicorn {{cookiecutter.project_slug}}.wsgi -b 0.0.0.0:8000