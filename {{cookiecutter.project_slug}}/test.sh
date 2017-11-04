#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

function run_test {
    # Construct correct path if using bash for windows
    if grep -q Microsoft /proc/version; then
        VOLUME_PATH="$(pwd | tr -d "\n" | sed -r "s#/mnt/([a-z]+)/#\1:/#")/${1}"
    else
        VOLUME_PATH="$(pwd | tr -d "\n")/${1}"
    fi

    # Run a given container for testing
    # Any fail here will stop the script (and the build)
    docker run --rm -v "${VOLUME_PATH}:/usr/src/${1}/src" "{{cookiecutter.project_slug}}/${1}:test"

    if [ "$?" != "0" ]; then
        echo -e "${RED}ERROR: an error occured during test of ${1}${NC}"
        exit 1
    fi
    echo -e "${GREEN}OK: Test of ${1} succeed.${NC}"
}

# Build every individual part for testing
./build.sh test

run_test backend
