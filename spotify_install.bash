#!/bin/bash
set -e

# Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo 'deb http://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install spotify-client

echo "Done :D"
