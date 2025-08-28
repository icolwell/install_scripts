#!/bin/bash
set -e

VERSION=${1:-'3.6.1'}
FILENAME="Godot_v$VERSION-stable_linux_server.64"
URL="https://github.com/godotengine/godot-builds/releases/download/$VERSION-stable/$FILENAME.zip"
INSTALL_DIR="$HOME/opt/godot-$VERSION"
TEMP_DIR=$(mktemp -d)

echo "Installing dependencies ..."
sudo apt update
sudo apt -y install unzip curl

cd "$TEMP_DIR"
echo "Downloading Godot Server version $VERSION ..."
curl --fail --location --output godot.zip "$URL"

mkdir -p "$INSTALL_DIR"
mkdir -p "$HOME/bin"
unzip -o godot.zip -d "$INSTALL_DIR"
ln -sf "$INSTALL_DIR/$FILENAME" "$HOME/bin/godot-server-$VERSION"
ln -sf "$HOME/bin/godot-server-$VERSION" "$HOME/bin/godot-server"

echo "Godot Server installed to:"
echo "$INSTALL_DIR"
