#!/bin/bash
set -e

# Syncthing
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install syncthing

# https://docs.syncthing.net/users/faq.html#how-do-i-increase-the-inotify-limit-to-get-my-filesystem-watcher-to-work
echo "fs.inotify.max_user_watches=204800" | sudo tee -a /etc/sysctl.conf
sudo sh -c 'echo 204800 > /proc/sys/fs/inotify/max_user_watches'

echo "Done :D"
