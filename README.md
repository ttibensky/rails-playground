# Rails Playground app

## Local usage

### First launch

```bash
docker compose up -d
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
```