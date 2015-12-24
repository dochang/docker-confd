FROM dochang/alpine-scripts:latest
MAINTAINER dochang@gmail.com

COPY scripts /scripts

RUN set -ex && \
    /scripts/golang/install.sh && \
    /scripts/confd/install.sh && \
    /scripts/golang/clean.sh && \
    /scripts/apk/clean.sh
