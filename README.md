# Install Scripts

[![CircleCI](https://circleci.com/gh/icolwell/install_scripts.svg?style=shield)](https://circleci.com/gh/icolwell/install_scripts)

This repo contains a collection of install scripts I have created over the years
to install software that is not easily installed via `apt install` using default apt sources.
The scripts are meant to be used on the latest stable
[LTS](https://wiki.ubuntu.com/LTS) release of Ubuntu.


# Using the Scripts

There is no need to clone this repo locally, the scripts can be ran as long as
an internet connection exists. Below is an example of running the Opera browser install
script.

```
curl -sSL https://raw.githubusercontent.com/icolwell/install_scripts/master/opera_install.bash | bash
```

# CI Testing

The majority of the scripts are tested on Ubuntu 22.04 and 20.04.
See the `.circleci/ci_test.bash` script for a list of untested scripts.
