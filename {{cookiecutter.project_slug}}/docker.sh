#!/usr/bin/env bash

if grep -q Microsoft /proc/version; then
    DOCKER="docker.exe"
else
    DOCKER="docker"
fi

${DOCKER} "$@"