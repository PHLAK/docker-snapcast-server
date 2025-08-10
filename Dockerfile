# --------- LIBRESPOT ----------

FROM debian:12.11 AS librespot

ARG LIBRESPOT_VERSION=0.6.0
ARG ZIP_PATH=/tmp/librespot.zip
ARG ZIP_URL=https://github.com/librespot-org/librespot/archive/refs/tags/v${LIBRESPOT_VERSION}.zip

RUN apt-get update && apt-get install --assume-yes build-essential curl libasound2-dev pkg-config unzip \
    && curl --location --output ${ZIP_PATH} ${ZIP_URL} && unzip ${ZIP_PATH} -d /tmp/ \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

WORKDIR /tmp/librespot-${LIBRESPOT_VERSION}

RUN ${HOME}/.cargo/bin/cargo build --release --no-default-features --features "alsa-backend"

# --------- SNAPCAST ----------

FROM debian:12.11
LABEL maintainer="Chris Kankiewicz <Chris@ChrisKankiewicz.com>"

ARG SNAPCAST_VERSION=0.32.3
ARG SNAPSERVER_DEB_URL=https://github.com/badaix/snapcast/releases/download/v${SNAPCAST_VERSION}/snapserver_${SNAPCAST_VERSION}-1_amd64_bookworm.deb

COPY --from=librespot /tmp/librespot-*/target/release/librespot /usr/local/bin/librespot

RUN mkdir --parents --verbose /vol/data

RUN apt-get update && apt-get install --assume-yes alsa-utils tzdata wget

RUN wget --directory-prefix /tmp/ ${SNAPSERVER_DEB_URL} \
    && apt-get install --assume-yes /tmp/snapserver_*.deb \
    && rm --verbose /tmp/snapserver_*.deb

VOLUME /var/lib/snapserver
EXPOSE 1704 1705 1780

CMD ["snapserver", "--config=/etc/snapserver.conf", "--logfilter=debug"]
