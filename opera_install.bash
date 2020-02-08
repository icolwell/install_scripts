#!/bin/bash
set -e

# References:
# https://askubuntu.com/a/1148025/688415

echo "Installing Opera ..."

sudo apt-get -y install wget

wget -qO - http://deb.opera.com/archive.key | sudo apt-key add -
echo 'deb https://deb.opera.com/opera-stable/ stable non-free' | sudo tee /etc/apt/sources.list.d/opera-stable.list
sudo apt-get -qq update

sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install opera-stable chromium-codecs-ffmpeg-extra
sudo ln -sf /usr/lib/chromium-browser/libffmpeg.so /usr/lib/x86_64-linux-gnu/opera/libffmpeg.so

echo "Opera installed successfully"
