#!/usr/bin/env bash

set -ue

export GOPATH=/tmp/go
export PATH=${GOPATH}/bin:$PATH
mkdir -p ${GOPATH}/bin
STELLAR_GO_PATH="${GOPATH}/src/github.com/stellar/go"

# install deps
apt-get update
apt-get install -y $BUILD_DEPS

# https://stackoverflow.com/questions/38378914/git-error-rpc-failed-curl-56-gnutls
git config --global http.postBuffer 1048576000

# install glide
cd /tmp
wget https://github.com/Masterminds/glide/releases/download/v${GLIDE_VERSION}/glide-v${GLIDE_VERSION}-linux-amd64.tar.gz
tar -xzvf glide-v${GLIDE_VERSION}-linux-amd64.tar.gz
cp linux-amd64/glide ${GOPATH}/bin/glide

# clone, compile, and install stellar core
git clone --branch $STELLAR_FRIENDBOT_VERSION --recursive --depth 1 https://github.com/stellar/go.git ${STELLAR_GO_PATH}

# install go packages
cd ${STELLAR_GO_PATH}
glide install

# install friendbot
go install github.com/stellar/go/services/friendbot
cp ${GOPATH}/bin/friendbot /usr/local/bin/friendbot

# install confd for config file management
wget -nv -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64
chmod +x /usr/local/bin/confd

# cleanup
rm -rf /tmp/glide-v${GLIDE_VERSION}-linux-amd64.tar.gz /tmp/linux-amd64 $GOPATH
apt-get remove -y $BUILD_DEPS
apt-get autoremove -y

# cleanup apt cache
rm -rf /var/lib/apt/lists/*
