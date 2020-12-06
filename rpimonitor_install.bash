#!/bin/bash
set -e

# https://xavierberger.github.io/RPi-Monitor-docs/11_installation.html+
# https://github.com/XavierBerger/RPi-Monitor/issues/267
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
echo "deb https://www.giteduberger.fr rpimonitor/" | sudo tee /etc/apt/sources.list.d/rpimonitor.list

sudo apt-get update
sudo apt-get -y install rpimonitor
sudo /etc/init.d/rpimonitor update
