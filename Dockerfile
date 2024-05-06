FROM debian:12.5
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

ARG SNAPCAST_VERSION=0.28.0
ARG SNAPSERVER_DEB_URL=https://github.com/badaix/snapcast/releases/download/v${SNAPCAST_VERSION}/snapserver_${SNAPCAST_VERSION}-1_amd64-bookworm.deb

RUN mkdir --parents --verbose /vol/data

RUN apt-get update && apt-get install --assume-yes alsa-utils tzdata wget

RUN wget --directory-prefix /tmp/ ${SNAPSERVER_DEB_URL} \
    && apt-get install --assume-yes /tmp/snapserver_*.deb \
    && rm --verbose /tmp/snapserver_*.deb

VOLUME /vol/data
EXPOSE 1704 1705 1780

CMD ["snapserver", "--config=/etc/snapserver.conf", "--server.datadir=/vol/data", "--logfilter=debug"]
