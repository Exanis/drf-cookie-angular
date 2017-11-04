FROM python:3.6.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/backend/requirements
RUN mkdir -p /usr/src/backend/src
WORKDIR /usr/src/backend

COPY ../../../backend/requirements/ ./requirements/
RUN pip install -u pip
RUN pip install -r requirements/production.txt

WORKDIR /usr/src/backend/src
COPY ../../../backend/ ./
RUN rm -rf requirements \
    requirements.txt \
    {{cookiecutter.project_slug}}/settings/local

EXPOSE 8000
CMD python manage.py migrate && python manage.py runserver_plus