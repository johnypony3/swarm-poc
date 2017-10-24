#!/bin/bash

sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo rm -rf /var/lib/dpkg/updates/*

sudo apt-get update -y

sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock

echo "updated"

sudo apt-get -y install python-pip
echo "pip installed"

sudo pip install awscli && pip install awscli
echo "pip installed awscli"
