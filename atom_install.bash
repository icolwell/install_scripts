#!/bin/bash
set -e

# https://flight-manual.atom.io/getting-started/sections/installing-atom/#installing-atom-on-linux

echo "Installing Atom ..."

wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -

sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get update -qq

sudo apt-get -y install atom

echo "Atom Installed."
