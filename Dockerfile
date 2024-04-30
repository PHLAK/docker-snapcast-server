FROM debian:12.5 as build
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

ARG SNAPCAST_VERSION=0.28.0
ARG ZIP_FILE=snapcast_${SNAPCAST_VERSION}_amd64-debian-bookworm.zip
ARG ZIP_URL=https://github.com/badaix/snapcast/releases/download/v${SNAPCAST_VERSION}/${ZIP_FILE}

RUN apt-get update && apt-get install --assume-yes ca-certificates unzip wget \
    && wget --directory-prefix /tmp/ ${ZIP_URL} && unzip /tmp/${ZIP_FILE} -d /tmp/

FROM debian:12.5

COPY --from=build /tmp/snapserver_*.deb /root/

RUN mkdir --parents --verbose /vol/data

RUN apt-get update && apt-get install --assume-yes alsa-utils tzdata \
    && apt-get install --assume-yes /root/snapserver_*.deb

VOLUME /vol/data
EXPOSE 1704 1705 1780

CMD ["snapserver", "--config=/etc/snapserver.conf", "--server.datadir=/vol/data", "--logfilter=debug"]
