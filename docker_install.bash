#!/bin/bash
set -e

# Docker

sudo apt-get -y install wget

wget -qO - https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install docker-ce

sudo usermod -a -G docker $USER

echo "Done :D"
