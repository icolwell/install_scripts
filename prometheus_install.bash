#!/bin/bash
set -e

# This script is based off of the tutorial found here:
# https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04

# Change these two variables to adjust which version you wish to install
VERSION="2.6.1"
SHA256="f5b281b72f6c80c4f972a0b75c1f47c1d747e0de6deec9d8ddc60c91c3cbfc30"

FOLDER="prometheus-$VERSION.linux-amd64"
ARCHIVE="$FOLDER.tar.gz"
TEMP_DIR=$(mktemp -d)

install()
{
    # Setup users and permissions
    id -u prometheus &>/dev/null || sudo useradd --no-create-home --shell /bin/false prometheus

    sudo mkdir -p /etc/prometheus
    sudo mkdir -p /var/lib/prometheus

    sudo chown prometheus:prometheus /etc/prometheus
    sudo chown prometheus:prometheus /var/lib/prometheus

    # Download and install prometheus binary
    cd "$TEMP_DIR"
    echo "Downloading prometheus version $VERSION ..."
    wget -q --show-progress "https://github.com/prometheus/prometheus/releases/download/v$VERSION/$ARCHIVE"
    DL_SHA=$(sha256sum "$TEMP_DIR/$ARCHIVE" | awk '{ print $1 }')

    if [ ! "$DL_SHA" == "$SHA256" ]; then
        echo "Downloaded archive does not match provided checksum"
        exit 1
    fi

    tar -xzf "$ARCHIVE"

    sudo cp "$FOLDER/prometheus" /usr/local/bin/
    sudo cp "$FOLDER/promtool" /usr/local/bin/

    sudo chown prometheus:prometheus /usr/local/bin/prometheus
    sudo chown prometheus:prometheus /usr/local/bin/promtool

    sudo cp -r "$FOLDER/consoles" /etc/prometheus/
    sudo cp -r "$FOLDER/console_libraries" /etc/prometheus/

    sudo chown -R prometheus:prometheus /etc/prometheus/consoles
    sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

    sudo cp "$FOLDER/prometheus.yml" /etc/prometheus/
    sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

    rm -rf "$FOLDER"

    # Setup systemd service
    cd /etc/systemd/system
    echo "Downloading systemd service file ..."
    sudo wget -q --show-progress https://raw.githubusercontent.com/icolwell/install_scripts/master/prometheus.service
    sudo systemctl daemon-reload
    sudo systemctl start prometheus.service
    sudo systemctl enable prometheus.service

    echo "Installation complete"
}

uninstall()
{
    echo "Uninstalling prometheus ..."

    # Remove service
    sudo systemctl stop prometheus.service
    sudo systemctl disable prometheus.service
    sudo rm /etc/systemd/system/prometheus.service
    sudo systemctl daemon-reload
    sudo systemctl reset-failed

    # Uninstall
    sudo rm -rf /etc/prometheus
    sudo rm -rf /var/lib/prometheus
    sudo rm /usr/local/bin/prometheus
    sudo rm /usr/local/bin/promtool

    echo "Prometheus uninstalled"
}

# Hack for sudo -v in docker containers
sudo echo -n

if [ "$1" == '-u' ]; then
    uninstall
else
    install
fi
