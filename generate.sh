#!/bin/bash

# 3c5f6d3ba7fe819c59feede15b7bb593d96a9e2c
SHATAG=$1
if [ ! $SHATAG ];then
  echo "SHATAG IS NULL ！"
  exit 100
fi

cat >docker-compose.yaml<<EOF
version: '3'

services:
  db:
    image: mysql:latest
    restart: always
    command:
      - mysqld
      - --max_connections=3000
      - --wait_timeout=600
      - --interactive_timeout=600
      - --thread_cache_size=50
      - --default-authentication-plugin=mysql_native_password
      - --character-set-server=utf8
      - --collation-server=utf8_general_ci
    environment:
      - MYSQL_DATABASE
      - MYSQL_ROOT_PASSWORD
      - MYSQL_USER
      - MYSQL_PASSWORD
      - TZ
    ports:
      - 3306:3306
    volumes:
      - ./bin/datas/mysql/:/var/lib/mysql
    container_name: db
    networks:
      - yibanclock-bridge

  web:
    image: hkccr.ccs.tencentyun.com/yiban_clock/yiban-django:$SHATAG
    restart: always
    environment:
      - MYSQL_DATABASE
      - MYSQL_ROOT_PASSWORD
      - MYSQL_USER
      - MYSQL_PASSWORD
      - MYSQL_HOST
      - MYSQL_PORT
      - TZ
    container_name: yiban_web
    depends_on:
      - db
    networks:
      - yibanclock-bridge

  nginx:
    image: hkccr.ccs.tencentyun.com/yiban_clock/yiban-nginx:$SHATAG
    restart: always
    environment:
      - TZ
    ports:
      - 80:80
    container_name: yiban_nginx
    depends_on:
      - web
    networks:
      - yibanclock-bridge

  clock:
    image: hkccr.ccs.tencentyun.com/yiban_clock/yiban-clock:$SHATAG
    environment:
      TZ: Asia/Shanghai     
    restart: always
    volumes:
      - ./:/app/
      - ./config/:/app/config/
    container_name: yiban_clock
    depends_on:
      - db
    networks:
      - yibanclock-bridge

networks:
  yibanclock-bridge:
    driver: bridge
EOF