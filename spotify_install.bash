#!/bin/bash
set -e

# Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo 'deb http://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install spotify-client

echo "Done :D"
