#!/bin/sh

set -e

python manage.py makemigrations
python manage.py migrate
python manage.py loaddata admin_interface_theme_django.json
python manage.py loaddata admin_interface_theme_bootstrap.json
python manage.py loaddata admin_interface_theme_foundation.json
python manage.py loaddata admin_interface_theme_uswds.json

/usr/local/bin/uwsgi --ini uwsgi.ini

exec "$@"
