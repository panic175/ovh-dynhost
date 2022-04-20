#!/bin/sh

echo "Version: $1"
set -e
docker build --platform linux/arm/v7 -t ovh-dynhost .
docker login -u panic158
docker tag ovh-dynhost:latest panic158/ovh-dynhost:latest
docker tag ovh-dynhost:latest panic158/ovh-dynhost:$1
docker push panic158/ovh-dynhost:latest 
docker push panic158/ovh-dynhost:$1 