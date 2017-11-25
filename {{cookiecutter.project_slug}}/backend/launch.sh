#!/usr/bin/env bash

until psql -h "db" -U "django" -c '\q' backend; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

python manage.py migrate
"$@"