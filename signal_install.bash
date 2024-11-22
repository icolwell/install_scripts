#!/bin/bash
set -e

# Source: https://signal.org/download/linux/

cd /tmp

wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | \
  sudo tee /etc/apt/sources.list.d/signal.list

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install signal-desktop

echo "Done :D"
