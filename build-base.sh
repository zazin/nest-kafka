#!/bin/bash

CI_REGISTRY_IMAGE='nurzazin/nest-kafka'
CONTAINER_IMAGE=$CI_REGISTRY_IMAGE:builder
DOCKER_FILE='builder.Dockerfile'

echo "---- Start Build ----"
docker build --pull -t $CONTAINER_IMAGE -f $DOCKER_FILE .
docker push $CONTAINER_IMAGE
echo "---- End Build ----"
