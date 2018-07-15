#!/bin/bash
set -e

sudo add-apt-repository -y ppa:minecraft-installer-peeps/minecraft-installer

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install minecraft-installer

echo "Done :D"
