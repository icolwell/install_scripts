#!/bin/bash
set -e

VERSION=${1:-'3.3.2'}
FILENAME="Godot_v$VERSION-stable_linux_headless.64"
URL="https://downloads.tuxfamily.org/godotengine/$VERSION/$FILENAME.zip"
INSTALL_DIR="$HOME/opt/godot-$VERSION"
TEMP_DIR=$(mktemp -d)

echo "Installing dependencies ..."
sudo apt update
sudo apt install unzip wget

cd "$TEMP_DIR"
echo "Downloading Godot Headless version $VERSION ..."
wget --quiet --show-progress "$URL" -O godot.zip

mkdir -p "$INSTALL_DIR"
mkdir -p "$HOME/bin"
unzip -o godot.zip -d "$INSTALL_DIR"
ln -sf "$INSTALL_DIR/$FILENAME" "$HOME/bin/godot-headless-$VERSION"
ln -sf "$HOME/bin/godot-headless-$VERSION" "$HOME/bin/godot-headless"

echo "Godot Headless installed to:"
echo "$INSTALL_DIR"
