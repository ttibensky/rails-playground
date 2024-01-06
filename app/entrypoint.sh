#!/bin/bash

set -x || exit 1

bundle check || bundle install || exit 1
bin/rails db:environment:set || exit 1
bin/rails db:migrate || exit 1
puma || exit 1
