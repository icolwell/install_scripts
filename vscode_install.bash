#!/bin/bash
set -e

# References:
# https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-18-04/

echo "Installing Visual Studio Code ..."

wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

#echo 'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main' | sudo tee /etc/apt/sources.list.d/code.list
sudo apt-get -qq update

sudo apt-get -y install code

echo "Visual Studio Code installed successfully"
