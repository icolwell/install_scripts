#!/bin/bash
set -e

# This script is based off of the tutorial found here:
# https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04

# Change these two variables to adjust which version you wish to install
VERSION="0.5.0"
SHA256="60dc120e0c5d9325beaec4289d719e3b05179531f470f87d610dc2870c118144"

FOLDER="apache_exporter-$VERSION.linux-amd64"
ARCHIVE="$FOLDER.tar.gz"
TEMP_DIR=$(mktemp -d)

install()
{
    # Setup users and permissions
    id -u apache_exporter &>/dev/null || sudo useradd --no-create-home --shell /bin/false apache_exporter

    # Download and install binary
    cd "$TEMP_DIR"
    echo "Downloading apache_exporter version $VERSION ..."
    wget -q --show-progress "https://github.com/Lusitaniae/apache_exporter/releases/download/v$VERSION/$ARCHIVE"
    DL_SHA=$(sha256sum "$TEMP_DIR/$ARCHIVE" | awk '{ print $1 }')

    if [ ! "$DL_SHA" == "$SHA256" ]; then
        echo "Downloaded archive does not match provided checksum"
        exit 1
    fi

    tar -xzf "$ARCHIVE"
    sudo cp "$FOLDER/apache_exporter" /usr/local/bin/
    sudo chown apache_exporter:apache_exporter /usr/local/bin/apache_exporter
    rm -rf "$FOLDER"

    # Setup systemd service
    cd /etc/systemd/system
    echo "Downloading systemd service file ..."
    sudo wget -q --show-progress https://raw.githubusercontent.com/icolwell/install_scripts/master/apache_exporter.service
    sudo systemctl daemon-reload
    sudo systemctl start apache_exporter.service
    sudo systemctl enable apache_exporter.service

    echo "Installation complete"
}

uninstall()
{
    echo "Uninstalling prometheus apache_exporter ..."

    # Remove service
    sudo systemctl stop apache_exporter.service
    sudo systemctl disable apache_exporter.service
    sudo rm /etc/systemd/system/apache_exporter.service
    sudo systemctl daemon-reload
    sudo systemctl reset-failed

    # Uninstall
    sudo rm /usr/local/bin/apache_exporter

    echo "Prometheus apache_exporter uninstalled"
}

sudo -v
if [ "$1" == '-u' ]; then
    uninstall
else
    install
fi

