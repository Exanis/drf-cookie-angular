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

You will the probably need to install your project ; this will basically just create the project on Github and link it to
CI tools you configured. You can do it as such (in the project root directory) :
```bash
$ make install
```

That's it, you're done !

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
- [Silk](https://github.com/jazzband/silk) : Montior your requests to watch slow sql query and slow code
- [Django extensions](https://github.com/django-extensions/django-extensions) : Add development tools for an easier debugging (shipped with Werkzeug)

##### The "let's do this faster" ones :
- [Django rest generators](https://github.com/Exanis/django-rest-generators) : Add a bunch of shortcuts when working with DRF

##### The "who, it looks good !" ones :
- [Django jet](https://github.com/geex-arts/django-jet) Nicer django administration