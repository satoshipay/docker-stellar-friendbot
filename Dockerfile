FROM debian:stretch-slim

# git tag from https://github.com/stellar/go
ARG STELLAR_FRIENDBOT_VERSION="horizon-v0.13.0"
ARG GLIDE_VERSION="0.13.1"
ARG BUILD_DEPS="git build-essential golang-go mercurial wget"
ARG CONFD_VERSION="0.16.0"

LABEL maintainer="hello@satoshipay.io"

# install stellar core and confd
ADD install.sh /
RUN /install.sh

EXPOSE 8000

# configuration options, see here for docs:
# https://github.com/stellar/go/blob/master/services/friendbot/friendbot.cfg
ENV \
  NETWORK_PASSPHRASE="Test SDF Network ; September 2015" \
  HORIZON_URL="https://horizon-testnet.stellar.org" \
  STARTING_BALANCE="10000.00"

ADD confd /etc/confd

ADD entry.sh /
ENTRYPOINT ["/entry.sh"]

CMD ["/usr/local/bin/stellar-friendbot", "--conf", "/stellar-friendbot.cfg"]
