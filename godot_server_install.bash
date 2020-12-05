#!/bin/bash
set -e

VERSION=${1:-'3.2.3'}
FILENAME="Godot_v$VERSION-stable_linux_server.64"
URL="https://downloads.tuxfamily.org/godotengine/$VERSION/$FILENAME.zip"
INSTALL_DIR="$HOME/opt/godot-$VERSION"
TEMP_DIR=$(mktemp -d)

cd "$TEMP_DIR"
echo "Downloading Godot Server version $VERSION ..."
wget --quiet --show-progress "$URL" -O godot.zip

mkdir -p "$INSTALL_DIR"
mkdir -p "$HOME/bin"
unzip godot.zip -d "$INSTALL_DIR"
ln -s "$INSTALL_DIR/$FILENAME" "$HOME/bin/godot-server"

echo "Godot Server installed to:"
echo "$INSTALL_DIR"
