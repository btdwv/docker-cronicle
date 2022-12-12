FROM lsiobase/alpine:3.16

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer=""

#ENV VERSION 0.9.17

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS 2

WORKDIR    /opt/cronicle/

RUN \
echo "**** install runtime packages ****" && \
apk add -U --no-cache curl npm tzdata python3 py3-pip build-base libffi-dev python3-dev jq && \
echo "**** install pip packages ****" && \
pip3 install --no-cache-dir -U pip      && \
pip3 install --no-cache-dir -U requests && \
pip3 install --no-cache-dir -U json5    && \
pip3 install --no-cache-dir -U aiohttp  && \
pip3 install --no-cache-dir -U python-dotenv && \
pip3 install --no-cache-dir -U PyYAML && \
apk del libffi-dev build-base python3-dev && \
echo "**** install Cronicle ****" && \
LOCATION=$(curl -s https://api.github.com/repos/jhuckaby/Cronicle/releases/latest | grep "tag_name" | awk '{print "https://github.com/jhuckaby/Cronicle/archive/" substr($2, 2, length($2)-3) ".tar.gz"}') && curl -L $LOCATION | tar zxvf - --strip-components 1 && \
npm install && \
node bin/build.js dist && \
echo "**** clean up ****" && \
rm -rf \
    /root/.cache \
    /tmp/*

COPY root/ /

EXPOSE 3012

VOLUME ["/opt/cronicle/data", "/opt/cronicle/logs"]
