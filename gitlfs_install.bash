#!/bin/bash
set -e

if [ -f /usr/bin/git-lfs ]; then
    echo "Git Large File Storage (LFS) is already installed."
else
    echo "Installing Git Large File Storage (LFS)..."
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
    sudo apt-get install git-lfs
    git lfs install
fi
