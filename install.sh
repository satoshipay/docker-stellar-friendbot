#!/usr/bin/env bash

set -ue

# install deps
apt-get update
apt-get install -y $STELLAR_FRIENDBOT_BUILD_DEPS $STELLAR_FRIENDBOT_DEPS

# install friendbot
wget https://github.com/stellar/go/releases/download/friendbot-v${STELLAR_FRIENDBOT_VERSION}/friendbot-v${STELLAR_FRIENDBOT_VERSION}-linux-amd64.tar.gz -O stellar-friendbot.tar.gz
tar -zxvf stellar-friendbot.tar.gz
mv friendbot-v${STELLAR_FRIENDBOT_VERSION}-linux-amd64/friendbot /usr/local/bin
chmod +x /usr/local/bin/friendbot

# install confd for config file management
wget -nv -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64
chmod +x /usr/local/bin/confd

# cleanup
rm -rf stellar-friendbot.tar.gz friendbot-v${STELLAR_FRIENDBOT_VERSION}-linux-amd64/
apt-get remove -y $STELLAR_FRIENDBOT_BUILD_DEPS
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
