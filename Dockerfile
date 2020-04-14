FROM lsiobase/alpine:3.11

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer=""

ENV VERSION 0.8.45

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS 2

RUN \
echo "**** install runtime packages ****" && \
apk add -U --no-cache docker-cli tini curl jq npm tzdata procps python2 py2-pip && \
echo "**** install pip packages ****" && \
pip install --no-cache-dir -U pip && \
pip install --no-cache-dir -U requests && \
echo "**** install Cronicle ****" && \
curl -sSL https://github.com/jhuckaby/Cronicle/archive/v${VERSION}.tar.gz | tar xz --strip-components=1 -C /app/ && \
    cd /app/ && npm install && \
    node bin/build.js dist \
echo "**** clean up ****" && \
rm -rf \
    /root/.cache \
    /tmp/*

COPY root/ /

EXPOSE 3012

VOLUME ["/config/data", "/config/logs"]
