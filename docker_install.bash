#!/bin/bash
set -e

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install docker-ce

echo "Done :D"
