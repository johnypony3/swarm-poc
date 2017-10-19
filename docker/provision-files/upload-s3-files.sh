#!/bin/bash

sudo chmod -R 777 ./docker

sudo chmod -R 744 ./docker/docker-config/mysql/config
sudo chmod -R 755 ./docker/docker-config/mysql/import

aws s3 rm --recursive s3://swarm-docker-data-mysql-compose/
aws s3 rm --recursive s3://swarm-docker-data-mysql-import/data/
aws s3 rm --recursive s3://swarm-docker-data-mysql-config/data/

aws s3 cp --recursive --exclude "*.DS_STORE" ./docker/compose-files               s3://swarm-docker-data-mysql-compose/
aws s3 cp --recursive --exclude "*.DS_STORE" ./docker/docker-config/mysql/import  s3://swarm-docker-data-mysql-import/data/
aws s3 cp --recursive --exclude "*.DS_STORE" ./docker/docker-config/mysql/config  s3://swarm-docker-data-mysql-config/data/
