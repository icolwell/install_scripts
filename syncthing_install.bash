#!/bin/bash
set -e

# Source: https://apt.syncthing.net/

sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

echo "Updating package lists ..."
sudo apt-get -qq update

sudo apt-get -y install syncthing

# Adjust inotify for filesystem watching
# https://docs.syncthing.net/users/faq.html#how-do-i-increase-the-inotify-limit-to-get-my-filesystem-watcher-to-work
SYS_FILE="/etc/sysctl.conf"
SYS_STRING="fs.inotify.max_user_watches=204800"
if grep -q "$SYS_STRING" "$SYS_FILE"; then
	sudo sh -c "echo $SYS_STRING >> $SYS_FILE"
fi

INOTIFY_FILE="/proc/sys/fs/inotify/max_user_watches"
if [ -w "$INOTIFY_FILE" ]; then
	sudo sh -c "echo 204800 > $INOTIFY_FILE"
fi

echo "Syncthing Installed :D"
