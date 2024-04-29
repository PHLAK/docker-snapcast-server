FROM debian:12.5
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

ARG SNAPCAST_VERSION=0.28.0
ARG ZIP_FILE=snapcast_${SNAPCAST_VERSION}_amd64-debian-bookworm.zip
ARG ZIP_URL=https://github.com/badaix/snapcast/releases/download/v${SNAPCAST_VERSION}/${ZIP_FILE}

RUN apt-get update && apt-get install --assume-yes ca-certificates tzdata unzip wget \
    && wget --directory-prefix /root/ ${ZIP_URL} && unzip /root/${ZIP_FILE} -d /root/ \
    && rm /root/${ZIP_FILE}

RUN apt-get install --assume-yes /root/snapserver_${SNAPCAST_VERSION}-1_amd64.deb

EXPOSE 1704 1705 1780

CMD ["snapserver", "--config", "/etc/snapserver.conf", "--logfilter", "debug"]
