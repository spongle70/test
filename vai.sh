#!/bin/sh
OS=alpine
VERSION=3.12.0

APP_USER='myapps'
APP_GROUP='myapps'
APP_UID='1001'
APP_GID='1001'
APP_VERSION=master

NAS_USER=donkey
NAS_GROUP=donkey
NAS_UID='1003'
NAS_GID='1003'
  
docker build --build-arg IMG_VERSION=${OS}:${VERSION} --build-arg NAS_USER=${NAS_USER} -t aaaa .
