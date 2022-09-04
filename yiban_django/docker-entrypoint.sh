#!/bin/sh

set -e

python manage.py makemigrations
python manage.py migrate

/usr/local/bin/uwsgi --ini uwsgi.ini

exec "$@"
