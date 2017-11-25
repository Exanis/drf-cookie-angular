#!/usr/bin/env bash


psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" <<-EOSQL
    CREATE DATABASE backend;
    CREATE ROLE django LOGIN REPLICATION PASSWORD '${POSTGRES_USER_PASSWORD}';
    ALTER DATABASE backend OWNER TO django;
EOSQL
