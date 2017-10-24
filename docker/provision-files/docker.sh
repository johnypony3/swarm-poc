#!/bin/bash

sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock

sudo apt-get update -y

sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock

#sudo apt-get upgrade -y
echo "updated"

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
echo "node installed"

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update -y
sudo apt-get install -y docker-ce
sudo gpasswd -a $USER docker
newgrp docker
docker --version
echo "docker installed"

sudo apt-get -y install python-pip
sudo pip install docker-compose
echo "docker-compose installed"

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt-get update && sudo apt-get install filebeat
sudo update-rc.d filebeat defaults 95 10
echo "filebeat installed"

sudo apt-get install -y htop git mysql-client-core-5.7
sudo pip install awscli && pip install awscli

echo "misc tools installed"

docker plugin install rexray/s3fs:latest  S3FS_ACCESSKEY=$AWS_ACCESS_KEY_ID S3FS_SECRETKEY=$AWS_SECRET_ACCESS_KEY --grant-all-permissions
docker volume ls
echo "installed s3 volume driver"
