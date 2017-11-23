#!/usr/bin/env bash

if grep -q Microsoft /proc/version; then
    DOCKER="docker.exe"
else
    DOCKER="docker"
fi

VOLUME_PATH="$(pwd | tr -d "\n")/${1}"

${DOCKER} run -d -v "${VOLUME_PATH}:/usr/src/${1}/src" --name "${2}" "{{cookiecutter.project_slug}}/${1}:development"
