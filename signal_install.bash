#!/bin/bash
set -e

curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install signal-desktop

echo "Done :D"
