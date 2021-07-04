#!/bin/bash
set -e

# References:
# https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-18-04/
# https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions

echo "Installing Visual Studio Code ..."

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main"

sudo apt-get -y install apt-transport-https
sudo apt-get -qq update
sudo apt-get -y install code

echo "Visual Studio Code installed successfully"
