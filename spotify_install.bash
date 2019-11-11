#!/bin/bash
set -e

# https://www.spotify.com/us/download/linux/

curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

echo "Updating package lists ..."
sudo apt-get update -qq

sudo apt-get -y install spotify-client

echo "Spotify installed successfully."
