#!/usr/bin/env bash

if grep -q Microsoft /proc/version; then
    chcp.com 850
    DOCKERCOMPOSE="docker-compose.exe"
else
    DOCKERCOMPOSE="docker-compose"
fi

${DOCKERCOMPOSE} "$@"
RET="$?"

if grep -q Microsoft /proc/version; then
    chcp.com 65001
fi

exit ${RET}