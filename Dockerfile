FROM lsiobase/alpine:3.11

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer=""

ENV VERSION 0.8.46

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS 2

RUN \
echo "**** install runtime packages ****" && \
apk add -U --no-cache curl npm tzdata python2 py2-pip && \
echo "**** install pip packages ****" && \
pip install --no-cache-dir -U pip && \
pip install --no-cache-dir -U requests && \
echo "**** install Cronicle ****" && \
curl -s https://raw.githubusercontent.com/jhuckaby/Cronicle/master/bin/install.js | node \
echo "**** clean up ****" && \
rm -rf \
    install.js \
    /root/.cache \
    /tmp/*

COPY root/ /

EXPOSE 3012

VOLUME ["/opt/cronicle/data", "/opt/cronicle/logs"]
