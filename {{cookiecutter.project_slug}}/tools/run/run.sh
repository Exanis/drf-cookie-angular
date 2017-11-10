#!/usr/bin/env bash

# Run a single container
# Used by Makefile to perform spectific commands in this container,
# this file is needed because of windows/linux path
if grep -q Microsoft /proc/version; then
    VOLUME_PATH="$(pwd | tr -d "\n" | sed -r "s#/mnt/([a-z]+)/#\1:/#")/${1}"
else
    VOLUME_PATH="$(pwd | tr -d "\n")/${1}"
fi

docker run -d -v "${VOLUME_PATH}:/usr/src/${1}/src" --name "${2}" "{{cookiecutter.project_slug}}/${1}:development"
