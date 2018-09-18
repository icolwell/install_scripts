#!/bin/bash
set -e

INSTALL_DIR="$HOME/opt"
VERSION='capella-1.2.1.201806011020-linux-gtk-x86_64'
XHTML_VERSION='CapellaXHTMLDocGen-dropins-1.2.0.201801081314'
URL=http://download.polarsys.org/capella/core/products/releases/1.2.1-R20180601-102021/"$VERSION".zip
XHTML_URL=http://download.polarsys.org/capella/addons/xhtmldocgen/dropins/releases/1.2.0/"$XHTML_VERSION".zip

main() {
    # Check if already installed
    if [ -e "$INSTALL_DIR/capella/eclipse/eclipse" ]; then
        echo "Capella is already installed"
        exit
    fi

    install_capella
}

install_capella() {
    sudo apt-get -y install unzip

    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    wget $URL
    mkdir -p "$INSTALL_DIR"
    unzip -qo "$VERSION.zip" -d "$INSTALL_DIR"
    chmod +x "$INSTALL_DIR/capella/eclipse/eclipse"

    # Install xhtml plugin
    wget "$XHTML_URL"
    unzip -qo "$XHTML_VERSION.zip"
    cp -R CapellaXHTMLDocGen/* "$INSTALL_DIR/capella/"

    # Edit the eclipse.ini
    # sed -i '1i2' "$INSTALL_DIR/capella/eclipse/eclipse.ini"
    # sed -i '1i--launcher.GTK_version' "$INSTALL_DIR/capella/eclipse/eclipse.ini"

    # Link to user's binary
    mkdir -p "$HOME/bin"
    cd "$HOME/bin"
    ln -sf ~/opt/capella/eclipse/eclipse capella

    echo "Capella installation completed"
}

main
