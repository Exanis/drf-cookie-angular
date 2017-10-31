# DRF, ready to use

This cookiecutter template provide you a full-configured base for a django + rest + angular project. It also add a few
simple tools to make your django use easier and cleaner.

[![Updates](https://pyup.io/repos/github/Exanis/drf-cookie-angular/shield.svg)](https://pyup.io/repos/github/Exanis/drf-cookie-angular/)

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

##### The "let's do this faster" ones :
- [Django rest generators](https://github.com/Exanis/django-rest-generators) : Add a bunch of shortcuts when working with DRF
