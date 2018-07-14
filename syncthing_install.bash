#!/bin/bash
set -e

# Syncthing
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install syncthing

echo "Done :D"
