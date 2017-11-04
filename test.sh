#!/usr/bin/env bash

# Prepare working directory
rm -rf target
mkdir -p target
cd target

# Create project
cookiecutter .. --no-input --overwrite-if-exists

# Run tests
cd project_name
./test.sh