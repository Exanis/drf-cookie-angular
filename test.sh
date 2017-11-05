#!/usr/bin/env bash

# Prepare working directory
rm -rf target
mkdir -p target
cd target

# Create project
cookiecutter .. --no-input --overwrite-if-exists

# Fix permissions
chmod +x project_name/test.sh \
    project_name/build.sh \
    project_name/backend/test.sh

# Run tests
cd project_name
./test.sh