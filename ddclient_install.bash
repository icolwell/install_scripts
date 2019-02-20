#!/bin/bash
set -e

# This script is based off of the README found here:
# https://github.com/ddclient/ddclient
# this script only installs ddclient version 3.8.3

VERSION="3.8.3"
SHA256="a7a39ff7c5092564a7d22f86cfcb747bad30b8c4d8bef30b518eded1f91cba43"

FOLDER="ddclient-$VERSION"
ARCHIVE="$FOLDER.tar.gz"
TEMP_DIR=$(mktemp -d)

install()
{
    echo "Installing dependencies ..."
    sudo apt-get -y install perl libdata-validate-ip-perl

    # Download and install binary
    cd "$TEMP_DIR"
    echo "Downloading ddclient version $VERSION ..."
    wget -q --show-progress "https://github.com/ddclient/ddclient/archive/v$VERSION.tar.gz"
    DL_SHA=$(sha256sum "$TEMP_DIR/$ARCHIVE" | awk '{ print $1 }')

    if [ ! "$DL_SHA" == "$SHA256" ]; then
        echo "Downloaded archive does not match provided checksum"
        exit 1
    fi

    tar -xzf "$ARCHIVE"

    sudo cp "$FOLDER/ddclient" /usr/sbin/
    sudo mkdir -p /etc/ddclient
    sudo mkdir -p /var/cache/ddclient
    rm -rf "$FOLDER"

    # Setup service
    sudo cp "$FOLDER/sample-etc_rc.d_init.d_ddclient.ubuntu" /etc/init.d/ddclient
    sudo update-rc.d ddclient defaults
    sudo service ddclient start

    # Cleanup
    rm -rf "$FOLDER"
    rm -rf "$ARCHIVE"

    echo "Installation complete"
}

uninstall()
{
    echo "Uninstalling ddclient ..."

    # Remove service
    sudo service ddclient stop
    sudo service ddlcient disable
    sudo rm /etc/init.d/ddclient
    sudo systemctl daemon-reload
    sudo systemctl reset-failed

    # Uninstall
    sudo rm /usr/sbin/ddclient

    echo "ddclient uninstalled"
}

purge()
{
    uninstall

    # Remove configs
    sudo rm -rf /etc/ddclient
    suod rm -rf /var/cache/ddclient
}

sudo -v
case "$1" in
    "-u")
        uninstall;;
    "-p")
        purge;;
    *)
        install;;
esac
