#!/usr/bin/env bash

# Run basic tests
coverage run $(which behave) --junit -f progress \
    && coverage run -a manage.py test api

if [ "${?}" != "0" ]; then
    exit 1
fi

# Format code coverage
coverage report -m
coverage xml

# Test code quality
pylint -f msvs api \
    && flake8 api