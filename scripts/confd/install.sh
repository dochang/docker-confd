#!/bin/sh

set -ex

# We can't use v0.12.1, since [this commit][1] is behind v0.12.1
#
# [1]: bacongobbler/confd@e464ce60793c0572626cc468ce681864d363ac3c
export CONFD_VERSION=master

export GOPATH=/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Install confd build dependencies.
apk add --no-cache --virtual confd-dependencies bash git

mkdir -p "${GOPATH}/src" "${GOPATH}/bin"

# Download confd source code.
pkgroot=github.com/bacongobbler/confd
git clone --branch "${CONFD_VERSION}" https://${pkgroot}.git "${GOPATH}/src/${pkgroot}"
export CGO_ENABLED=0
go get ${pkgroot}

# Install confd.
cd "${GOPATH}/bin"
install -c confd /usr/local/bin
cd /

# Remove confd source repo
rm -rf "${GOPATH}"

# Delete confd build dependencies.
apk del --purge confd-dependencies
