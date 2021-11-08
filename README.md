# Contact Importer Test

## Requirements

- Ruby > 3.0
- Postgresql > 9.3
- Redis: > 4.0

## Setup

In the project directory:
`bundle install`
`bundle exec rails db:create db:migrate`

## Running in your local

To start the server:
`bundle exec rails s`

To start sidekiq in order to process background jobs:
`bundle exec sidekiq`

## Import files

There is a sample CSV file located in `fixtures/contacts_sample.csv`

In the same folder there are a couple of samples to test different scenarios.
