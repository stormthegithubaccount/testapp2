# Django dev-setup

- local development environment with docker-compose
- prod deploymement with helm chart to any kubernetes cluster (for example: minikube or google kubenetes engine (GKE))


## Local Dev


### Prerequisite

  - docker
  - docker-compose

### Run dev

1. Setup the enviroment

- docker-compose.yml file is created with different docker images to be used.
  + the dev service with our `django-dev:develop` image which is built from the build-dev.sh file.
    We use this file to build the development environment for django app (with the Dockerfile-dev file)
  + Other services (db, memcached, redis) is added with standard docker images. We can use the service
    names as hostname to connect to these services.

- `Pipfile` is used to install python package dependencies to be used for the django app (https://github.com/pypa/pipfile)

- We use environment variables for configurating the app, .env and .env-dev is used to create env vars
  for `dev` and `db` services in the docker-compose.yml file (https://docs.docker.com/compose/environment-variables/#the-env_file-configuration-option)

- `app` directory is the django app entry point; `home` and `polls` are all standard Django applications.

- we use run-dev.sh bash script to run the dev service

- we use run-migration.sh bash script to run any migration for the django app


2. Run the app

To run the app, we need to run the following commands:

  ```
  $ sh build-dev.sh
  $ docker-compose up -d dev
  $ docker-compose logs -f dev # for logging
  $ docker-compose exec dev pipenv run python manage.py createsuperuser
  $ docker-compose exec dev pipenv run sh run-migration.sh
  ```

3. Run command within the dev container

  ```
  $ docker-compose exec dev sh
  ...
  $ docker-compose exec dev pipenv run <cmd>
  ```

### Testing

1. Test Caching:
  - Stripe
    Go to `/admin/djstripe/` and check it out

  - memcached:
    ```
    MEMCACHED_ENABLED=enabled && REDIS_ENABLED=disabled && docker-compose up -d dev
    ```

  - redis:
    ```
    REDIS_ENABLED=enabled && MEMCACHED_ENABLED=disabled && docker-compose up -d dev
    ```
  
  Go to `/memcached`, `/redis` to see timestamp results


## prod deployment

- we use helm chart for prod deployment, see helm-charts/django-app/README.md for details

