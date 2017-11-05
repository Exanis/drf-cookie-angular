FROM python:3.6.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/backend/requirements
RUN mkdir -p /usr/src/backend/src
WORKDIR /usr/src/backend

COPY src/requirements/ ./requirements/
RUN pip install -U pip
RUN pip install -r requirements/test.txt

EXPOSE 8000
ENV DJANGO_SETTINGS_MODULE {{cookiecutter.project_slug}}.settings.test
WORKDIR /usr/src/backend/src
CMD /bin/bash -c "/usr/src/backend/src/test.sh"