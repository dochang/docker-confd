FROM dochang/alpine-scripts:latest
MAINTAINER dochang@gmail.com

COPY scripts /scripts

RUN set -ex && \
    /scripts/golang/install.sh && \
    /scripts/confd/install.sh && \
    /scripts/golang/clean.sh && \
    rm -rf /var/cache/apk/* && \
    # `apk del` doesn't remove the unavailable symlinks in /etc/ssl, we remove them.
    rm -rf /etc/ssl
