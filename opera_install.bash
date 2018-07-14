#!/bin/bash
set -e

# Opera
wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
echo 'deb https://deb.opera.com/opera-stable/ stable non-free' | sudo tee /etc/apt/sources.list.d/opera-stable.list

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install opera-stable

echo "Done :D"
