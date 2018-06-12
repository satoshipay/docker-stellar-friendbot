# Stellar Friendbot Docker image

[![Docker Build Status](https://img.shields.io/docker/build/satoshipay/stellar-friendbot.svg)](https://hub.docker.com/r/satoshipay/stellar-friendbot/)

## Docker Hub

The Docker images are published at [satoshipay/stellar-friendbot](https://hub.docker.com/r/satoshipay/stellar-friendbot/).

## Configuration

The Friendbot can be configured with the following environment variables:

 * `FRIENDBOT_SECRET`: secret of the account that holds funds.
 * `NETWORK_PASSPHRASE` (optional): the passphrase identifying the network, default is `Test SDF Network ; September 2015`.
 * `HORIZON_URL` (optional): the Horizon server where the transactions should be sent, default is `https://horizon-testnet.stellar.org`.
 * `STARTING_BALANCE` (optional): the amount in XLM to send, default is `10000.00`.
