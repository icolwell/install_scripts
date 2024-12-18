#!/bin/bash
set -e

# References:
# https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions

echo "Installing Visual Studio Code ..."

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt-get -y install apt-transport-https
sudo apt-get -qq update
sudo apt-get -y install code

echo "Visual Studio Code installed successfully"
