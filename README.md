# DRF, ready to use

This cookiecutter template provide you a full-configured base for a django + rest + angular project. It also add a few
simple tools to make your django use easier and cleaner.

[![Updates](https://pyup.io/repos/github/Exanis/drf-cookie-angular/shield.svg)](https://pyup.io/repos/github/Exanis/drf-cookie-angular/)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/a9623d959e6b4a798f5644085fe425cd)](https://www.codacy.com/app/Exanis/drf-cookie-angular?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Exanis/drf-cookie-angular&amp;utm_campaign=Badge_Grade)
[![Build Status](https://travis-ci.org/Exanis/drf-cookie-angular.svg?branch=master)](https://travis-ci.org/Exanis/drf-cookie-angular)

## Installing

drf-cookie-angular (DCA) is a [CookieCutter](https://github.com/audreyr/cookiecutter) template, and as such can be used
as simply as running two commands :
- First one to install cookiecutter :
```bash
$ pip install cookiecutter
```

- Then the second one to create your new project :
```bash
$ cookiecutter gh:exanis/drf-cookie-angular 
```

That's it, you're done !

### Cookiecutter parameters

Here is the list of parameters used when creating your project (those parameters will be prompted by cookiecutter):

- **project_name**: Name of your project
- **project_slug**: A different version of the name of the project (will be auto-generated for you)
- **author_name**: Your name
- **email**: Your email
- **description**: A short description (one line) of the project
- **expose_database**: If set to *y*, docker-compose will expose your database on port 5432. It's probably a better idea to leave it to *n* unless you block this port by yourself on most IPs
- **use_github**: If set to *y*, a github project will be generated (your password will be prompt to generate it, together will the ssh keys used by github)
- **github_owner**: Your Github user name
- **github_user_type**: If you want to create the project on your own github account, leave this to "user". If you want to create it on an organisation account, set the organization name here
- **repository_type**: *private* or *public*
- **use_travis**: Leave *y* to add your project to travis, set to *n* to not
- **use_codacy**: Leave *y* to add your project to codacy, set to *n* to not

### Auto-install feature

When you create your project, it will automatically be installed (as in, a few commands will be run to prepare a DB, etc.)
If you want to avoid this, you can set the ``DRF_COOKIE_NO_INSTALL`` environment variable to 1 when using the ``cookiecutter`` command.

You can always install the project later by using ``make install``, or install it locally (without creating a github project)
with ``make install_local`` (see your project's README for more on this topic)

## Shipped with goods

##### The "I could have guessed those" ones :
- [Django](https://www.djangoproject.com/)
- [Django rest framework](http://www.django-rest-framework.org/)

##### The "of course" ones :
- [Django guardian](https://django-guardian.readthedocs.io/en/stable/) : Add object-level permission to your models
- [Django redis](https://niwinz.github.io/django-redis/latest/) : Redis is used in production build as default cache engine

##### The "best practices" ones :
- [Django environ](https://github.com/joke2k/django-environ) : Make configuration-in-environment great again
- [Behave](https://github.com/behave/behave) : Behavior Driven Development in python
- [Coverage](https://coverage.readthedocs.io/en/coverage-4.4.1/) : Coverage reporting
- [Pylint](https://www.pylint.org/) : _(development only)_ Let you test your code beauty
- [Flake8](https://gitlab.com/pycqa/flake8) : _(development only)_ Work with pylint to test your code beauty

##### The "all-seeing eye" ones :
- [Django extensions](https://github.com/django-extensions/django-extensions) : Add development tools for an easier debugging (shipped with Werkzeug)

##### The "let's do this faster" ones :
- [Django rest generators](https://github.com/Exanis/django-rest-generators) : Add a bunch of shortcuts when working with DRF

##### The "who, it looks good !" ones :
- [Django jet](https://github.com/geex-arts/django-jet) Nicer django administration