FROM python:3.6.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/backend/requirements
RUN mkdir -p /usr/src/backend/src
WORKDIR /usr/src/backend

COPY src/requirements/ ./requirements/
RUN pip install -U pip
RUN pip install -r requirements/development.txt

VOLUME ["/usr/src/backend/src"]

EXPOSE 8000
WORKDIR /usr/src/backend/src
CMD python manage.py migrate && python manage.py runserver_plus