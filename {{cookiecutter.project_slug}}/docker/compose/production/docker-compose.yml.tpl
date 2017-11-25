version: '3'
services:
  backend:
    image: {{cookiecutter.project_slug}}/backend:production
    environment:
      - DEBUG=off
      - SECRET_KEY=@@SECRET_KEY@@
      - ALLOWED_HOST=backend
      - REDIS_URL=redis://redis:6379/1
      - DATABASE_URL=pgsql://django:@@POSTGRES_PASSWORD@@@db:5432/backend
      - PGPASSWORD=@@POSTGRES_PASSWORD@@
    volumes:
      - ../../../backend:/usr/src/backend/src
      - ../../../frontend/api/media:/usr/src/media
      - ../../../frontend/api/static:/usr/src/static
    ports:
      - 8000
    links:
      - redis:redis
      - db:db
  frontend:
    image: {{cookiecutter.project_slug}}/frontend:production
    volumes:
      - ../../../frontend/api/:/var/www/api/
    links:
      - backend:backend
    ports:
      - 80:80
  redis:
    image: redis:3.2.11
    ports:
      - 6379
  db:
    image: {{cookiecutter.project_slug}}/database:production
    environment:
      - POSTGRES_PASSWORD=@@POSTGRES_SU_PASSWORD@@
      - POSTGRES_USER_PASSWORD=@@POSTGRES_PASSWORD@@
    volumes:
      - ../../../database/volume:/var/lib/postgresql/data
    ports:
{% if cookiecutter.expose_database == 'y' %}
      - 5432:5432
{% else %}
      - 5432
{% endif %}