#!/bin/bash
set -e

# https://www.spotify.com/us/download/linux/

curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

echo "Updating package lists ..."
sudo apt-get -qq update

sudo apt-get -y install spotify-client

echo "Spotify installed successfully."
