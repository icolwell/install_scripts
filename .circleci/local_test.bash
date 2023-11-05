#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$SCRIPT_DIR/.."

# Workflows can't be tested locally, run each job
# circleci local execute focal_desktop-testing
circleci local execute jammy_desktop-testing

# Uncomment the following to do local debugging
# docker run -it \
# 	-v "$PWD:/home/user/install_scripts" \
# 	iancolwell/ubuntu:jammy_desktop \
# 	/bin/bash
