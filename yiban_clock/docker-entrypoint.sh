#!/bin/sh

set -e

if [ ! $MYSQL_USER ];then
  echo "The environment variable MYSQL_USER empty got: $MYSQL_USER"
  exit 100
fi
if [ ! $MYSQL_PASSWORD ];then
  echo "The environment variable MYSQL_USER empty got: $MYSQL_PASSWORD"
  exit 100
fi
if [ ! $MYSQL_HOST ];then
  echo "The environment variable MYSQL_USER empty got: $MYSQL_HOST"
  exit 100
fi
if [ ! $MYSQL_PORT ];then
  echo "The environment variable MYSQL_USER empty got: $MYSQL_PORT"
  exit 100
fi
if [ ! $MYSQL_DATABASE ];then
  echo "The environment variable MYSQL_USER empty got: $MYSQL_DATABASE"
  exit 100
fi
if [ ! $MAIL_USER ];then
  echo "The environment variable MYSQL_USER empty got: $MAIL_USER"
  exit 100
fi
if [ ! $MAIL_PASS ];then
  echo "The environment variable MYSQL_USER empty got: $MAIL_PASS"
  exit 100
fi
if [ ! $MAIL_HOST ];then
  echo "The environment variable MYSQL_USER empty got: $MAIL_HOST"
  exit 100
fi
if [ ! -f /app/config/config.json ];then
  mkdir -p /app/config
  cp /config.json /app/config/config.json
  sed -i 's/$MYSQL_USER/'$MYSQL_USER'/g' /app/config/config.json
  sed -i 's/$MYSQL_PASSWORD/'$MYSQL_PASSWORD'/g' /app/config/config.json
  sed -i 's/$MYSQL_HOST/'$MYSQL_HOST'/g' /app/config/config.json
  sed -i 's/$MYSQL_PORT/'$MYSQL_PORT'/g' /app/config/config.json
  sed -i 's/$MYSQL_DATABASE/'$MYSQL_DATABASE'/g' /app/config/config.json
  
  sed -i 's/$MAIL_USER/'$MAIL_USER'/g' /app/config/config.json
  sed -i 's/$MAIL_PASS/'$MAIL_PASS'/g' /app/config/config.json
  sed -i 's/$MAIL_HOST/'$MAIL_HOST'/g' /app/config/config.json
fi
set +e

exec "$@"
