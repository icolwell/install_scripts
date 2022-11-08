#!/bin/bash
set -e

# Based on brave's install instructions:
# https://brave.com/linux/#release-channel-installation

echo "Installing Brave Browser ..."

sudo apt-get -qq update
sudo apt-get -y install apt-transport-https curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
	| sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null

sudo apt-get -qq update
sudo apt-get -y install brave-browser

echo ""
echo "Brave installed :D"
