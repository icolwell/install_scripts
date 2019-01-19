#!/bin/bash
set -e

# This script is based off of the tutorial found here:
# https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04

# Change these two variables to adjust which version you wish to install
VERSION="0.17.0"
SHA256="d2e00d805dbfdc67e7291ce2d2ff151f758dd7401dd993411ff3818d0e231489"

FOLDER="node_exporter-$VERSION.linux-amd64"
ARCHIVE="$FOLDER.tar.gz"
TEMP_DIR=$(mktemp -d)

install()
{
    # Setup users and permissions
    id -u node_exporter &>/dev/null || sudo useradd --no-create-home --shell /bin/false node_exporter

    # Download and install prometheus binary
    cd "$TEMP_DIR"
    echo "Downloading node_exporter version $VERSION ..."
    wget -q --show-progress "https://github.com/prometheus/node_exporter/releases/download/v$VERSION/$ARCHIVE"
    DL_SHA=$(sha256sum "$TEMP_DIR/$ARCHIVE" | awk '{ print $1 }')

    if [ ! "$DL_SHA" == "$SHA256" ]; then
        echo "Downloaded archive does not match provided checksum"
        exit 1
    fi

    tar -xzf "$ARCHIVE"
    sudo cp "$FOLDER/node_exporter" /usr/local/bin/
    sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
    rm -rf "$FOLDER"

    # Setup systemd service
    cd /etc/systemd/system
    echo "Downloading systemd service file ..."
    sudo wget -q --show-progress https://raw.githubusercontent.com/icolwell/install_scripts/master/node_exporter.service
    sudo systemctl daemon-reload
    sudo systemctl start node_exporter.service
    sudo systemctl enable node_exporter.service

    echo "Installation complete"
}

uninstall()
{
    echo "Uninstalling prometheus node_exporter ..."

    # Remove service
    sudo systemctl stop node_exporter.service
    sudo systemctl disable node_exporter.service
    sudo rm /etc/systemd/system/node_exporter.service
    sudo systemctl daemon-reload
    sudo systemctl reset-failed

    # Uninstall
    sudo rm /usr/local/bin/node_exporter

    echo "Prometheus node_exporter uninstalled"
}

sudo -v
if [ "$1" == '-u' ]; then
    uninstall
else
    install
fi

