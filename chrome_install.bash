#!/bin/bash
set -e

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install google-chrome-stable

echo "Done :D"
