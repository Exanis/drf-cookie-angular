#!/usr/bin/env bash

read -sp "Github password for {{cookiecutter.github_owner}}: " PASSWORD
echo
read -p "SSH key directory for github user {{cookiecutter.github_owner}}: [~/.ssh/] " KEY
echo

if [ -z "${KEY}" ]; then
    KEY='~/.ssh/'
fi

if grep -q Microsoft /proc/version; then
    VOLUME_PATH="$(pwd | tr -d "\n" | sed -r "s#/mnt/([a-z]+)/#\1:/#")/${1}"
    KEY_PATH="$(eval cd ${KEY} > /dev/null ; pwd | tr -d "\n" | sed -r "s#/mnt/([a-z]+)/#\1:/#" ; cd - > /dev/null)/${1}"
else
    VOLUME_PATH="$(pwd | tr -d "\n")/${1}"
    KEY_PATH="$(eval cd ${KEY} > /dev/null ; pwd ; cd - > /dev/null)/${1}"
fi

mkdir ./tools/install/ssh/
cp ${KEY_PATH}/* ./tools/install/ssh/

docker build -t="{{cookiecutter.project_slug}}_install" tools/install
docker run --rm -v "${VOLUME_PATH}:/usr/src/content/" -e "GITHUB_PASSWORD=${PASSWORD}" "{{cookiecutter.project_slug}}_install"
RESULT=${?}
docker rmi "{{cookiecutter.project_slug}}_install"
exit ${RESULT}