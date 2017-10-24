#!/bin/bash

docker --version
echo "docker installed"

sudo pip install docker-compose && pip install docker-compose
docker-compose version
echo "docker-compose installed"

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt-get update && sudo apt-get install filebeat
sudo update-rc.d filebeat defaults 95 10
echo "filebeat installed"

sudo apt-get install -y htop git mysql-client-core-5.7
echo "misc tools installed"

sudo npm install -g sequelize-cli@2.8.0
sudo npm install -g phantom phantomjs-prebuilt
sudo npm install -g bower gulp-cli mysql
sudo npm install -g swagger
echo "node prereqs installed"

sudo apt-get autoremove -y
echo "cleaned up"
