# Help
help:
	@echo "List of available commands:"
	@echo "---------------------------"
	@echo "Tools:"
	@echo "    help: Display this help"
	@echo "    validate: Run all tests of current code"
	@echo "    run: Run the code and let you test it on local computer"
	@echo
	@echo "Django tools"
	@echo "    migrationns: Generate backend migrations (as python manage.py makemigrations)"
	@echo "    single_shell: Open a shell in the container, separated from any previous / current run"
	@echo "    single_django_shell: Open a python shell in the container, with django loaded, separated from any previous / current run"
	@echo "    running_shell: Open a shell in the current running backend container (will fail if none)"
	@echo "    running_django_shell: Open a python shell, with django loaded, in the current running backend container (will fail if none)"
	@echo "    app: Create a new app in django (using create_app command)"
	@echo "    model: Create a new model in django (using create_model command)"
	@echo "    rest: Turn a model to a rest model, creating tests, viewset and serializers (using make_rest_model command)"
	@echo
	@echo "Install"
	@echo "    install: Install current project in the disk and on github"
	@echo "    install_permissions: Install current project without github"
	@echo
	@echo "Git shortcuts"
	@echo "    branch: Create a new branch and add it to the remote"

# Testing commands
validate:
	./tools/run/test.sh

# Run commands
build_dev:
	./tools/run/build.sh development

run: build_dev
	docker-compose up


# Django command
migrations: build_dev
	./tools/run/run.sh backend migration-backend
	docker exec -it migration-backend python manage.py makemigrations
	docker stop migration-backend
	docker rm migration-backend

single_shell: build_dev
	./tools/run/run.sh backend shell-backend
	docker exec -it shell-backend /bin/bash
	docker stop shell-backend
	docker rm shell-backend

single_django_shell: build_dev
	./tools/run/run.sh backend django-shell-backend
	docker exec -it django-shell-backend python manage.py shell_plus
	docker stop django-shell-backend
	docker rm django-shell-backend

running_shell:
	docker exec -it backend /bin/bash

running_django_shell:
	docker exec -it backend python manage.py shell_plus

app:
    ./tools/run/run.sh backend create-app-backend
    @read -p "Application name: " APP \
        && docker exec -it create-app-backend python manage.py create_app ${APP}
    docker stop create-app-backend
    docker rm create-app-backend

model:
    ./tools/run/run.sh backend create-model-backend
    @read -p "Model name: " NAME; \
        @read -p "Application name [api]: " APP; \
        if [ -z "${APP}" ]; then APP='api'; fi; \
        docker exec -it create-model-backend python manage.py create_model ${APP} ${NAME}
    docker stop create-model-backend
    docker rm create-model-backend

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
        && docker exec -it create-model-backend python manage.py make_rest_model ${APP} ${NAME} -p ${PERMS}
    docker stop create-model-backend
    docker rm create-model-backend

# Install command
install_permissions:
	chmod +x ./tools/*/*.sh
	chmod +x ./backend/test.sh

install_github: install_permissions
	tools/install/install.sh
	rm -rf tools/install

install: install_github

# Git command
branch:
	git checkout master
	git pull
	@read -p "Branch name: " name \
		&& git checkout -b ${name} \
		&& git push --set-upstream origin ${name}
