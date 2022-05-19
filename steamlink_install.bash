#!/bin/bash
set -e

CODENAME="$(lsb_release -sc)"
ARCH="$(arch)"

if [ "$CODENAME" != "bullseye" ] || [ "$ARCH" != "aarch64" ]; then
	echo "This script has not been tested on anything other than 64-bit Raspberry Pi OS 11 (bullseye, aarch64)"
	echo "If you are running 32-bit Raspberry Pi OS, you can likely just run 'sudo apt install steamlink'"
	exit 1
fi

# Install steamlink
sudo apt-get -y install steamlink

# Run steamlink at least once for setup prompts
steamlink

# Missing dependencies
sudo apt-get -y install libgles2:armhf libegl1:armhf libgl1-mesa-glx:armhf libsndio7.0:armhf libavcodec58:armhf

# Symlink library versions
cd "/lib/arm-linux-gnueabihf"

sudo ln -s libbcm_host.so.0 libbcm_host.so
sudo ln -s libvcsm.so.0 libvcsm.so
sudo ln -s libmmal.so.0 libmmal.so
sudo ln -s libmmal_core.so.0 libmmal_core.so
sudo ln -s libmmal_util.so.0 libmmal_util.so

echo ""
echo "Steamlink installed :)"
