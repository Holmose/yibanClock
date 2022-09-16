#!/bin/sh

set -e

if [ ! $MYSQL_USER ];then
  echo "The environment variable MYSQL_USER empty"
  exit 100
fi
if [ ! $MYSQL_PASSWORD ];then
  echo "The environment variable MYSQL_USER empty"
  exit 100
fi
if [ ! $MYSQL_HOST ];then
  echo "The environment variable MYSQL_USER empty"
  exit 100
fi
if [ ! $MYSQL_PORT ];then
  echo "The environment variable MYSQL_USER empty"
  exit 100
fi
if [ ! $MYSQL_DATABASE ];then
  echo "The environment variable MYSQL_USER empty"
  exit 100
fi

mkdir -p /app/config
cp /config.json /app/config/config.json
sed -i 's/$MYSQL_USER/'$MYSQL_USER'/g' /app/config/config.json
sed -i 's/$MYSQL_PASSWORD/'$MYSQL_PASSWORD'/g' /app/config/config.json
sed -i 's/$MYSQL_HOST/'$MYSQL_HOST'/g' /app/config/config.json
sed -i 's/$MYSQL_PORT/'$MYSQL_PORT'/g' /app/config/config.json
sed -i 's/$MYSQL_DATABASE/'$MYSQL_DATABASE'/g' /app/config/config.json

set +e

exec "$@"