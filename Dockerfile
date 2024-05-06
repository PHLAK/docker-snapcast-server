FROM alpine:edge
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

ARG SNAPCAST_VERSION=0.28.0-r1
ARG SNAPWEB_ZIP_URL=https://github.com/badaix/snapweb/releases/download/v0.7.0/snapweb.zip

RUN mkdir --parents --verbose /vol/data

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --update --no-cache alsa-utils librespot wget snapcast-server=${SNAPCAST_VERSION} \
    && rm -rf /var/cache/apk/*

RUN wget --output-document /tmp/snapweb.zip ${SNAPWEB_ZIP_URL} \
    && unzip -o -d /usr/share/snapserver/snapweb/ /tmp/snapweb.zip \
    && rm /tmp/snapweb.zip

VOLUME /vol/data
EXPOSE 1704 1705 1780

CMD ["snapserver", "--config=/etc/snapserver.conf", "--server.datadir=/vol/data", "--logfilter=debug"]
