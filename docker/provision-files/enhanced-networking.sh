#!/bin/bash

sudo sed -i '/#if UTS_UBUNTU_RELEASE_ABI > 255/c\/*#if UTS_UBUNTU_RELEASE_ABI > 255' /usr/src/ixgbevf-2.16.4/src/kcompat.h
sudo apt-get update #&& sudo apt-get upgrade -y
sudo apt-get install -y dkms
wget "sourceforge.net/projects/e1000/files/ixgbevf stable/2.16.4/ixgbevf-2.16.4.tar.gz"
tar -xzf ixgbevf-2.16.4.tar.gz

sudo mv dkms.conf ixgbevf-2.16.4/
sudo mv ixgbevf-2.16.4 /usr/src/

sudo dkms add -m ixgbevf -v 2.16.4
sudo dkms build -m ixgbevf -v 2.16.4
sudo dkms install -m ixgbevf -v 2.16.4
sudo update-initramfs -c -k all
modinfo ixgbevf
