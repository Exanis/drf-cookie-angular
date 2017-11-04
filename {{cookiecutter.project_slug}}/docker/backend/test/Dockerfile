FROM python:3.6.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/backend/requirements
RUN mkdir -p /usr/src/backend/src
WORKDIR /usr/src/backend

COPY ../../../backend/requirements/ ./requirements/
RUN pip install -u pip
RUN pip install -r requirements/test.txt

VOLUME ["/usr/src/backend/src"]

EXPOSE 8000
CMD /bin/bash -c "/usr/src/backend/src/test.sh"