#!/usr/bin/env bash

DOCKER="tools/common/docker.sh"

VOLUME_PATH="$(pwd | tr -d "\n")/${1}"

${DOCKER} run -d -v "${VOLUME_PATH}:/usr/src/${1}/src" --name "${2}" "{{cookiecutter.project_slug}}/${1}:development"
