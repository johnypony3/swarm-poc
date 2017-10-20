#!/bin/bash
echo $DOCKER_COMPOSE_FILE

docker-compose -f "./docker/compose-files/$DOCKER_COMPOSE_FILE" down
docker-compose -f "./docker/compose-files/$DOCKER_COMPOSE_FILE" kill
docker-compose -f "./docker/compose-files/$DOCKER_COMPOSE_FILE" up --build -d
