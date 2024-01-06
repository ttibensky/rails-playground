# Rails Playground app

## Local usage

### First launch

```bash
docker compose up -d
# if the rails container exists with an error, check the logs and restart it
# at the first startup, the database is being initialized and until it's done, rails won't be able to connect to it
```

### Helpful commands

```bash
# connecting to the database
docker compose exec postgres psql -d rails -U rails

# create a local sql dump
docker compose exec postgres pg_dump -U rails rails > ./postgres/init/rails.sql

# run database migrations
docker compose exec rails rails db:migrate

# run seeds
docker compose exec rails rails db:seed

# update simulus manifest after adding new controllers manually
docker compose exec rails rails stimulus:manifest:update

# test puppeteer crawler
curl -H 'content-type: application/json' -d '{"url":"https://www.airbnb.com/h/roofdeckhottub"}' localhost:3001/reviews/airbnb
```

There is a seed user that use can use to login:
- email: `john.doe@example.com`
- password: `john.doe@example.com`

This user already has the test listing created, and all reviews synced.
