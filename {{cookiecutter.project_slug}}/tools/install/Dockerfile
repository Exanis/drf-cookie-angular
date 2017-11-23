# Install script use latest python3 version and latest packages version
FROM python:3.6.3

COPY ./requirements.txt /usr/src/requirements.txt
RUN pip install -r /usr/src/requirements.txt

COPY ./install.py /usr/src/install.py

WORKDIR /usr/src/
CMD python install.py