FROM debian:stretch-slim

ARG STELLAR_FRIENDBOT_VERSION="0.0.2"
ARG STELLAR_FRIENDBOT_BUILD_DEPS="wget"
ARG STELLAR_FRIENDBOT_DEPS="curl jq"
ARG CONFD_VERSION="0.16.0"

LABEL maintainer="hello@satoshipay.io"

# install stellar friendbot
ADD install.sh /
RUN /install.sh

# HTTP port
EXPOSE 8000

ENV \
  NETWORK_PASSPHRASE="Test SDF Network ; September 2015" \
  HORIZON_URL="https://horizon-testnet.stellar.org" \
  STARTING_BALANCE="10000.00" \
  NUM_MINIONS=1000

ADD confd /etc/confd

ADD entry.sh /
ENTRYPOINT ["/entry.sh"]

CMD ["/usr/local/bin/friendbot", "--conf", "/stellar-friendbot.cfg"]
