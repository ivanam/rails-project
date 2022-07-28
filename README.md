# Rails 6 on Docker demo application

This app demonstrates Rails 6 with PostgreSQL and Webpack (with jsbundling-rails), all running in Docker.


## Initial setup
```
docker compose build
docker compose run --rm web bin/rails db:setup db:migrate
```

## Running the Rails app
```
docker compose up
```

## Running the Rails console
When the app is already running with `docker-compose` up, attach to the container:
```
docker compose exec web bin/rails c
```

When no container running yet, start up a new one:
```
docker compose run --rm web bin/rails c
```

## Running tests
```
docker compose run --rm web bundle exec rspec
```

