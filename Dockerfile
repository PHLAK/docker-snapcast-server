FROM alpine:3.19.1
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

ARG SNAPCAST_VERSION=0.27.0-r4

RUN mkdir /etc/snapcast

RUN apk add --update --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing librespot \
    && apk add --update alsa-utils snapcast=${SNAPCAST_VERSION} && rm -rf /var/cache/apk/* \
    && rm -rf /var/cache/apk/*

EXPOSE 1704 1705 1780

CMD ["snapserver", "--config", "/etc/snapserver.conf"]
