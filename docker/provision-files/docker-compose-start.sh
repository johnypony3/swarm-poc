#!/bin/bash

docker-compose -f "./docker/compose-files/$DOCKER_COMPOSE_FILE" down
docker-compose -f "./docker/compose-files/$DOCKER_COMPOSE_FILE" kill
docker-compose -f "./docker/compose-files/$DOCKER_COMPOSE_FILE" up --build -d
