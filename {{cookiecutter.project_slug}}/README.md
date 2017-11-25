# {{ cookiecutter.project_name }}

{{ cookiecutter.description }}

## Prerequisites

Most of this project is made to run using Docker and Make,
using a lot of Bash scripts to make everything works together.

As such, you will need a few tools to be able to use this project
as it is meant to be used ; here is a quick summary of everything
you will need :

- Make
- Docker
- Docker-compose
- Bash

### Windows

If you are using this project on windows, there is a few more step
you will have to take in order to make it works. Specifically, you will need to :

- use it on Bash For Windows (aka Linux Subsystem for Windows)
- install docker on your Windows environment (outside of LSW)
- make a few changes to be able to bind the correct commands in your
windows environment

You will then need to add the following to your .bashrc file in order
to use correct path for your docker-compose :

```bash
# mount /mnt/c to /c if not already done
if [ ! -d "/c" ] || [ ! "$(ls -A /c)" ]; then
  echo "Requiring root password to $(tput setaf 6)mount --bind /mnt/c /c$(tput sgr 0)"
  sudo mkdir -p /c
  sudo mount --bind /mnt/c /c
fi

# Change from /mnt/c/... to /c/...
if [ "$(pwd | cut -c -7)" == "/mnt/c/" ]; then
  cd "$(pwd | cut -c 5-)"
fi
```

And then import it to your current environment :

```bash
$ source ~/.bashrc
```

## Make commands

To manage your project, a few helpful commands are integrated and can be
runned from the root of the project. Here is a complete list :

- **help** : Display a small reminder of the available commands
- **validate** : Run all test on your code
- **run** : Run the project on your computer (on port 80)
- **migrations** : Make migrations for your django project
- **single_shell** : On a new container, open a shell (doesn't hook on a currently running container)
- **single_django_shell** : On a new container, open a django python shell (doesn't hook on a currently running container)
- **running_shell** : Hook on a currently running container and open a shell
- **running_django_shell** : Hook on a currently running container and open a django python shell
- **app** : Create a new application
- **model** : Create a new model
- **rest** : Generate serializers, viewsets and tests for a given model
- **install_local** : Prepare your local environment to work with the project
- **deploy** : Generate a docker-compose file to use on production environment
- **branch**: Create a new branch of the project

## Production usage

To deploy your project on production, we suggest docker-compose. This, however, is mostly a
suggestion of how things should interact - any other way, like docker services + swarm, can pe used.

In order to avoid putting sensitive data on your repository, no docker-compose file is present in the project.
Instead, a development docker-compose.yml is generated (and ignored) on the local computer when you first create
the project ; to replicate it on any other computer, you can run ``make install_local``

To create the same kind of docker-compose, with settings adapted to production, you can run ``make deploy``
The resulting docker-compose.yml can be found in ``docker/compose/production`` folder.