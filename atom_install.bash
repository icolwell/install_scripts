#!/bin/bash
set -e

sudo add-apt-repository -y ppa:webupd8team/atom

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install atom

echo "Done :D"
