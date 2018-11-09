#!/bin/bash
set -e

VERSION="VeloView-3.5.0-Linux-64bit"
URL="https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.1&type=app&os=win32&downloadFile=$VERSION.tar.gz"
INSTALL_DIR="$HOME/opt"
TEMP_DIR=$(mktemp -d)

cd "$TEMP_DIR"
wget "$URL" -O veloview.tar.gz
mkdir -p "$INSTALL_DIR"
tar -C "$INSTALL_DIR" -xzf veloview.tar.gz

echo "VeloView Installed to:"
echo "$INSTALL_DIR"
