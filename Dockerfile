FROM alpine:3.19.1
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

ARG SNAPCAST_VERSION=0.27.0-r4

RUN mkdir /etc/snapcast

RUN apk add --update --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing librespot \
    && apk add --no-cache --update alsa-utils snapcast-server=${SNAPCAST_VERSION} && rm -rf /var/cache/apk/*

EXPOSE 1704 1705 1780

CMD ["snapserver", "--config", "/etc/snapserver.conf", "--logfilter", "debug"]
