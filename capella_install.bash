#!/bin/bash
set -e

INSTALL_DIR="$HOME/opt"
# VERSION='capella-1.1.2.2017-08-01_10-31-42-linux-gtk-x86_64-mars'
VERSION='capella-1.2.1.201806011020-linux-gtk-x86_64'
# XHTML_VERSION='CapellaXHTMLDocGen-dropins-1.1.0.2017-01-24_06-14-20-incubation'
XHTML_VERSION='CapellaXHTMLDocGen-dropins-1.2.0.201801081314'

URL=http://download.polarsys.org/capella/core/products/releases/1.2.1-R20180601-102021/"$VERSION".zip
XHTML_URL=http://download.polarsys.org/capella/addons/xhtmldocgen/dropins/releases/1.2.0/"$XHTML_VERSION".zip

# Install capella
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
wget $URL
mkdir -p "$INSTALL_DIR"
# tar -xf "$VERSION.tar.gz" -C "$INSTALL_DIR"
unzip -q "$VERSION.zip" -d "$INSTALL_DIR"
chmod +x "$INSTALL_DIR/capella/eclipse/eclipse"

# Install xhtml plugin
sudo apt-get -y install unzip
wget "$XHTML_URL"
unzip -q "$XHTML_VERSION.zip"
cp -R CapellaXHTMLDocGen/* "$INSTALL_DIR/capella/"

# Edit the eclipse.ini
# sed -i '1i2' "$INSTALL_DIR/capella/eclipse/eclipse.ini"
# sed -i '1i--launcher.GTK_version' "$INSTALL_DIR/capella/eclipse/eclipse.ini"

# Link to user's binary
mkdir -p "$HOME/bin"
cd "$HOME/bin"
ln -sf ~/opt/capella/eclipse/eclipse capella

# rm -rf "$VERSION.zip"
# rm -rf "$XHTML_VERSION.zip"

echo "Capella installation completed"
