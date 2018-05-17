#!/bin/bash
set -e

VERSION="1.8.3"

if [ -d /usr/local/go ]; then
	echo "GO is already installed"
else
	TEMP_DIR=$(mktemp -d)
	cd "$TEMP_DIR"
	wget https://storage.googleapis.com/golang/go$VERSION.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf go$VERSION.linux-amd64.tar.gz
fi
