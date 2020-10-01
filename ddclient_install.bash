#!/bin/bash
set -e

# This script is based off of the README found here:
# https://github.com/ddclient/ddclient

main()
{
	case "$1" in
		"-u")
			uninstall;;
		"-p")
			purge;;
		"-v")
			if [ -n "$2" ]; then
				VERSION="$2"
			else
				echo "Provide the version number"
				exit
			fi
			install;;
		*)
			install;;
	esac
}

install()
{
	# Hack for "sudo -v" in docker container
	sudo -v

	: "${VERSION:="3.9.1"}"
	if [ "$VERSION" == "3.9.0" ]; then
		SHA256="9c4ae902742e8a37790d3cc8fad4e5b0f38154c76bba3643f4423d8f96829e3b"
	else
		SHA256="e4969e15cc491fc52bdcd649d4c2b0e4b1bf0c9f9dba23471c634871acc52470"
	fi

	FOLDER="ddclient-$VERSION"
	ARCHIVE="v$VERSION.tar.gz"
	TEMP_DIR=$(mktemp -d)

	echo "Installing dependencies ..."
	sudo apt-get -qq install perl libdata-validate-ip-perl

	# Download and install binary
	cd "$TEMP_DIR"
	echo "Downloading ddclient version $VERSION ..."
	wget -q --show-progress "https://github.com/ddclient/ddclient/archive/v$VERSION.tar.gz"
	DL_SHA=$(sha256sum "$TEMP_DIR/$ARCHIVE" | awk '{ print $1 }')

	if [ ! "$DL_SHA" == "$SHA256" ]; then
		echo "Downloaded archive does not match provided checksum"
		exit 1
	fi

	tar -xzf "$ARCHIVE"

	# Patch
	if [ "$VERSION" == "3.9.0" ]; then
		patch_file
	fi

	sudo cp "$FOLDER/ddclient" /usr/sbin/
	sudo mkdir -p /etc/ddclient
	sudo mkdir -p /var/cache/ddclient

	# Setup service
	sudo cp "$FOLDER/sample-etc_rc.d_init.d_ddclient.ubuntu" /etc/init.d/ddclient
	sudo update-rc.d ddclient defaults
	sudo service ddclient start

	# Cleanup
	rm -rf "$FOLDER"
	rm -rf "$ARCHIVE"

	echo "Installation complete"
}

uninstall()
{
	sudo -v
	echo "Uninstalling ddclient ..."

	# Remove service
	sudo service ddclient stop || true
	sudo rm -f /etc/init.d/ddclient
	sudo systemctl daemon-reload
	sudo systemctl reset-failed

	# Uninstall
	sudo rm -f /usr/sbin/ddclient

	echo "ddclient uninstalled"
}

purge()
{
	uninstall

	# Remove configs
	sudo rm -rf /etc/ddclient
	sudo rm -rf /var/cache/ddclient

	echo "ddclient configs purged"
}

patch_file()
{
	cd "$FOLDER"
	echo "Patching ..."

	# Download patch
	wget -q "https://raw.githubusercontent.com/icolwell/install_scripts/master/ddclient-3.9.0.patch"

	sudo apt-get -qq install patch
	patch < ddclient-3.9.0.patch
	cd ..
}

main "$@"
