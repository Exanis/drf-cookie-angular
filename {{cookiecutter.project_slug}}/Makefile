DOCKER=tools/common/docker.sh
DOCKERCOMPOSE=tools/common/docker-compose.sh

# Help
help:
	@echo "List of available commands:"
	@echo "---------------------------"
	@echo "Tools:"
	@echo "	help: Display this help"
	@echo "	validate: Run all tests of current code"
	@echo "	run: Run the code and let you test it on local computer"
	@echo " deploy: Generate a docker-compose file to use on production environment"
	@echo " install_local: Install the project on your local environment"
	@echo
	@echo "Django tools"
	@echo "	migrations: Generate backend migrations (as python manage.py makemigrations)"
	@echo "	single_shell: Open a shell in the container, separated from any previous / current run"
	@echo "	single_django_shell: Open a python shell in the container, with django loaded, separated from any previous / current run"
	@echo "	running_shell: Open a shell in the current running backend container (will fail if none)"
	@echo "	running_django_shell: Open a python shell, with django loaded, in the current running backend container (will fail if none)"
	@echo "	app: Create a new app in django (using create_app command)"
	@echo "	model: Create a new model in django (using create_model command)"
	@echo "	rest: Turn a model to a rest model, creating tests, viewset and serializers (using make_rest_model command)"
	@echo " static: Collect all static files on the project. This is probably not what you want to do."
	@echo
	@echo "Git shortcuts"
	@echo "	branch: Create a new branch and add it to the remote"

# Testing commands
validate:
	./tools/run/test.sh

# Run commands
build_dev:
	./tools/run/build.sh development

run: build_dev
	$(DOCKERCOMPOSE) -f docker/compose/development/docker-compose.yml up

# Django command
migrations: build_dev
	./tools/run/run.sh backend migration-backend
	$(DOCKER) exec -it migration-backend python manage.py makemigrations
	$(DOCKER) stop migration-backend
	$(DOCKER) rm migration-backend

single_shell: build_dev
	./tools/run/run.sh backend shell-backend
	$(DOCKER) exec -it shell-backend /bin/bash
	$(DOCKER) stop shell-backend
	$(DOCKER) rm shell-backend

single_django_shell: build_dev
	./tools/run/run.sh backend django-shell-backend
	$(DOCKER) exec -it django-shell-backend python manage.py shell_plus
	$(DOCKER) stop django-shell-backend
	$(DOCKER) rm django-shell-backend

running_shell:
	$(DOCKER) exec -it development_backend_1 /bin/bash

running_django_shell:
	$(DOCKER) exec -it development_backend_1 python manage.py shell_plus

static: build_dev
	$(DOCKERCOMPOSE) -f docker/compose/development/docker-compose.yml up -d
	$(DOCKER) exec development_backend_1 python manage.py collectstatic --no-input
	$(DOCKERCOMPOSE) -f docker/compose/development/docker-compose.yml down

app:
	./tools/run/run.sh backend create-app-backend
	@read -p "Application name: " APP \
		&& $(DOCKER) exec -it create-app-backend python manage.py create_app ${APP}
	$(DOCKER) stop create-app-backend
	$(DOCKER) rm create-app-backend

model:
	./tools/run/run.sh backend create-model-backend
	@read -p "Model name: " NAME; \
		@read -p "Application name [api]: " APP; \
		if [ -z "${APP}" ]; then APP='api'; fi; \
		$(DOCKER) exec -it create-model-backend python manage.py create_model ${APP} ${NAME}
	$(DOCKER) stop create-model-backend
	$(DOCKER) rm create-model-backend

rest:
	./tools/run/run.sh backend create-model-backend
	@read -p "Model name: " NAME; \
		@read -p "Application name [api]: " APP; \
		@echo "Possible permissions: "; \
		@echo " - everyone"; \
		@echo " - auth"; \
		@echo " - auth_or_read_only"; \
		@echo " - model"; \
		@echo " - model_or_read_only"; \
		@echo " - object"; \
		@echo " - object_or_read_only"; \
		@echo " - object_or_anon_read_only"; \
		@echo " - admin"; \
		@read -p "Permissions [object]: " PERMS; \
		if [ -z "${APP}" ]; then APP='api'; fi; \
		if [ -z "${PERMS}" ]; then PERMS='object'; fi; \
		&& $(DOCKER) exec -it create-model-backend python manage.py make_rest_model ${APP} ${NAME} -p ${PERMS}
	$(DOCKER) stop create-model-backend
	$(DOCKER) rm create-model-backend

# Install command
generate_keys:
    $(eval SECRET_KEY:=$(shell head -n 400 /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 60 | head -n 1 | tr -d '\n'))
    $(eval POSTGRES_SU_PASSWORD:=$(shell head -n 400 /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 60 | head -n 1 | tr -d '\n'))
    $(eval POSTGRES_PASSWORD:=$(shell head -n 400 /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 60 | head -n 1 | tr -d '\n'))

install_key: generate_keys
	sed "s/@@SECRET_KEY@@/$(SECRET_KEY)/" ./docker/compose/development/docker-compose.yml.tpl > ./docker/compose/development/docker-compose.yml
	sed -i "s/@@POSTGRES_SU_PASSWORD@@/$(POSTGRES_SU_PASSWORD)/" ./docker/compose/development/docker-compose.yml
	sed -i "s/@@POSTGRES_PASSWORD@@/$(POSTGRES_PASSWORD)/" ./docker/compose/development/docker-compose.yml

install_permissions:
	chmod +x ./tools/*/*.sh
	chmod +x ./backend/test.sh
	chmod +x ./backend/launch.sh
	chmod +x ./database/init-user.sh

install_local: install_permissions install_key static

install_github: install_local
	./tools/install/install.sh
	rm -rf tools/install

{% if cookiecutter.use_github == 'y' %}
install: install_github
{% else %}
install: install_local
{% endif %}

# Deployement
deploy: install_permissions generate_keys
	sed "s/@@SECRET_KEY@@/$(SECRET_KEY)/" ./docker/compose/production/docker-compose.yml.tpl > ./docker/compose/production/docker-compose.yml
	sed -i "s/@@POSTGRES_SU_PASSWORD@@/$(POSTGRES_SU_PASSWORD)/" ./docker/compose/production/docker-compose.yml
	sed -i "s/@@POSTGRES_PASSWORD@@/$(POSTGRES_PASSWORD)/" ./docker/compose/production/docker-compose.yml

# Git command
branch:
	git checkout master
	git pull
	@read -p "Branch name: " name \
		&& git checkout -b ${name} \
		&& git push --set-upstream origin ${name}
