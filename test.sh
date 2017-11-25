#!/usr/bin/env bash

# Prepare working directory
rm -rf target
mkdir -p target
cd target

# Create project
env DRF_COOKIE_NO_INSTALL=1 cookiecutter .. --no-input --overwrite-if-exists
pwd
ls -lRa
# Fix permissions
chmod +x project_name/tools/*/*.sh \
    project_name/backend/test.sh

# Run tests
cd project_name
./tools/run/test.sh