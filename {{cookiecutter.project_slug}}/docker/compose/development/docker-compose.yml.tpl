version: '3'
services:
  backend:
    image: {{cookiecutter.project_slug}}/backend:development
    environment:
      - DEBUG=on
      - SECRET_KEY=@@SECRET_KEY@@
      - ALLOWED_HOST=backend,localhost
      - DATABASE_URL=pgsql://django:@@POSTGRES_PASSWORD@@@db:5432/backend
      - PGPASSWORD=@@POSTGRES_PASSWORD@@
    volumes:
      - ../../../backend:/usr/src/backend/src
      - ../../../frontend/api/media:/usr/src/media
      - ../../../frontend/api/static:/usr/src/static
    ports:
      - 8000:8000
    links:
      - db:db
  frontend:
    image: {{cookiecutter.project_slug}}/frontend:development
    volumes:
      - ../../../frontend/api/:/var/www/api/
    links:
      - backend:backend
    ports:
      - 80:80
  db:
    image: {{cookiecutter.project_slug}}/database:development
    environment:
      - POSTGRES_PASSWORD=@@POSTGRES_SU_PASSWORD@@
      - POSTGRES_USER_PASSWORD=@@POSTGRES_PASSWORD@@
    ports:
      - 5432:5432