FROM lsiobase/alpine:3.10

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer=""

ENV VERSION 0.8.32

RUN \
    apk add -U --no-cache docker-cli tini curl jq npm tzdata procps && \
    mkdir -p /opt/cronicle && curl -sSL https://github.com/jhuckaby/Cronicle/archive/v${VERSION}.tar.gz | tar xz --strip-components=1 -C /opt/cronicle && \
    cd /opt/cronicle && npm install && \
    node bin/build.js dist
    
    
EXPOSE 3012

VOLUME ["/opt/cronicle/data", "/opt/cronicle/logs", "/opt/cronicle/plugins"]
