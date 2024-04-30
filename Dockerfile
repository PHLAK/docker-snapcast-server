FROM alpine:3.19.1
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

ARG SNAPCAST_VERSION=0.28.0-r1
ARG LIBRESPOT_VERSION=0.4.2-r4

RUN mkdir --parents --verbose /vol/data

RUN apk add --update --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing librespot=${LIBRESPOT_VERSION} \
    && apk add --update --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/edge/community snapcast=${SNAPCAST_VERSION} \
    && apk add --no-cache --update alsa-utils \
    && rm -rf /var/cache/apk/*

VOLUME /vol/data
EXPOSE 1704 1705 1780

CMD ["snapserver", "--config=/etc/snapserver.conf", "--server.datadir=/vol/data", "--logfilter=debug"]
