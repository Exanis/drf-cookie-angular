#!/usr/bin/env bash

read -sp "Github password for {{cookiecutter.github_owner}}: " PASSWORD
echo
read -p "SSH key directory for github user {{cookiecutter.github_owner}}: [~/.ssh/] " KEY
echo

if [ -z "${KEY}" ]; then
    KEY='~/.ssh/'
fi

if grep -q Microsoft /proc/version; then
    DOCKER="docker.exe"
else
    DOCKER="docker"
fi

VOLUME_PATH="$(pwd | tr -d "\n")/${1}"
KEY_PATH="$(eval cd ${KEY} > /dev/null ; pwd ; cd - > /dev/null)/${1}"

mkdir ./tools/install/ssh/
cp ${KEY_PATH}/* ./tools/install/ssh/

${DOCKER} build -t="{{cookiecutter.project_slug}}_install" tools/install
${DOCKER} run --rm -v "${VOLUME_PATH}:/usr/src/content/" -e "GITHUB_PASSWORD=${PASSWORD}" "{{cookiecutter.project_slug}}_install"
RESULT=${?}
${DOCKER} rmi "{{cookiecutter.project_slug}}_install"
exit ${RESULT}