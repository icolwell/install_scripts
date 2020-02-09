#!/bin/bash
set -e

# Source:
# https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

echo "Updating package lists ..."
sudo apt update -qq

sudo apt -y install elasticsearch

echo "Done :D"
