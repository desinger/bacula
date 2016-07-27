#!/bin/bash

set -e

host="mysql"
shift
cmd="$@"

until psql -h "$host" -U "root" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd
