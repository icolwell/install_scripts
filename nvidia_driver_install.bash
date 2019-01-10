#!/bin/bash
set -e

# Update the following 2 variables to change the driver version
VERSION="410.93"
RUNFILE_MD5="ab3ab098e3d408eafe43284ff0e0240a"

NVIDIA_RUNFILE="NVIDIA-Linux-x86_64-$VERSION.run"
URL="http://us.download.nvidia.com/XFree86/Linux-x86_64/$VERSION/$NVIDIA_RUNFILE"
DL_DIR="$HOME/Downloads"

main() {
    if [ ! "$1" == '-y' ]; then
        prompt
    fi
    sudo -v

    if [ ! -e "$DL_DIR/$NVIDIA_RUNFILE" ]; then
        download_runfile
    fi

    # Check file
    md5=$(md5sum "$DL_DIR/$NVIDIA_RUNFILE" | awk '{ print $1 }')
    if [ ! "$md5" == "$RUNFILE_MD5" ]; then
        download_runfile
    fi

    # Install
    sudo service lightdm stop
    chmod +x "$DL_DIR/$NVIDIA_RUNFILE"
    cd "$DL_DIR"
    sudo ./$NVIDIA_RUNFILE -a -s

    echo "Completed, you can now restart lightdm using:"
    echo "sudo service lightdm start"
}

prompt() {
    echo "This script must be run in a virtual console."
    echo "You can enter a virtual console by pressing Ctrl->Alt->F1"
    echo "Do you wish to continue? (y/n):"

    while read ans; do
        case "$ans" in
            y) break;;
            n) exit; break;;
            *) echo "(y/n):";;
        esac
    done
}

download_runfile() {
    mkdir -p "$DL_DIR"
    cd "$DL_DIR"
    rm -f "$NVIDIA_RUNFILE"
    wget "$URL"
}

main
