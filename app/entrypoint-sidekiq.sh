#!/bin/bash

set -x || exit 1
bin/rails db:environment:set || exit 1
bundle exec sidekiq || exit 1
