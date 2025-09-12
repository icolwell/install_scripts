#!/bin/bash
set -e

VERSION=${1:-'3.6.1'}
FILENAME="Godot_v$VERSION-stable_x11.64"
URL="https://github.com/godotengine/godot-builds/releases/download/$VERSION-stable/$FILENAME.zip"
INSTALL_DIR="$HOME/opt/godot-$VERSION"
TEMP_DIR=$(mktemp -d)

echo "Installing dependencies ..."
sudo apt update
sudo apt -y install unzip curl libx11-dev libxcursor-dev \
	libxinerama-dev libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev \
	libfreetype6-dev libssl-dev libudev-dev libxrandr-dev libxi-dev

cd "$TEMP_DIR"
echo "Downloading Godot version $VERSION ..."
curl --fail --location --output godot.zip "$URL"

mkdir -p "$INSTALL_DIR"
mkdir -p "$HOME/bin"
unzip -o godot.zip -d "$INSTALL_DIR"
ln -sf "$INSTALL_DIR/$FILENAME" "$HOME/bin/godot-$VERSION"
ln -sf "$HOME/bin/godot-$VERSION" "$HOME/bin/godot"

echo "Godot Installed to:"
echo "$INSTALL_DIR"
