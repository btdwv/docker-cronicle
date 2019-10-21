FROM lsiobase/alpine:3.10

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer=""

ENV VERSION 0.8.32

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS 2

RUN \
    apk add -U --no-cache docker-cli tini curl jq npm tzdata procps && \
    curl -sSL https://github.com/jhuckaby/Cronicle/archive/v${VERSION}.tar.gz | tar xz --strip-components=1 -C /app/ && \
    cd /app/ && npm install && \
    node bin/build.js dist 
    
COPY root/ /
    
EXPOSE 3012

VOLUME ["/config/data", "/config/logs"]
