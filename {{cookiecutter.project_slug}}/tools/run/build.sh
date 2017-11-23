#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if grep -q Microsoft /proc/version; then
    DOCKER="docker.exe"
else
    DOCKER="docker"
fi

function build {
    # Prepare environment
    GIT_COMMIT=$(git rev-parse --short HEAD)
    BUILD_DATE=$(date '+%Y%m%d-%H%M%S')
    TAG_VERSION="${BUILD_DATE}.${GIT_COMMIT}"
    IMAGE_NAME="{{cookiecutter.project_slug}}/${1}:${TAG_VERSION}"

    # Erase previous artifact (used if previous build failed)
    rm -rf target
    mkdir -p target/src

    # Prepare content to build from
    cp -r "${1}"/* target/src
    cp "docker/${1}/${2}/Dockerfile" target/

    # Build
    ${DOCKER} build -t="${IMAGE_NAME}" target

    # Check
    if [ "$?" != "0" ]; then
        echo -e "${RED}ERROR: Cannot build ${1}/${2}${NC}"
        exit 1
    fi

    # Tag
    if [ "${2}" == "production" ]; then
        ${DOCKER} tag ${IMAGE_NAME} "{{cookiecutter.project_slug}}/${1}:latest"
    else
        ${DOCKER} tag ${IMAGE_NAME} "{{cookiecutter.project_slug}}/${1}:${2}"
    fi

    # Clean working environment
    rm -rf target

    # Display ok for this one
    echo -e "${GREEN}OK: Build of ${1}/${2} complete${NC}"
}

if [ -z "${1}" ]; then
    TARGET="production"
else
    TARGET="${1}"
fi

build backend ${TARGET}
RET=$?