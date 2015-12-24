#!/bin/sh

set -ex

export CONFD_VERSION=v0.11.0

prefix=/usr/local
confd_src_dir=${prefix}/src/confd
go_root=${prefix}/go

# Install confd build dependencies.
apk add --update-cache --virtual confd-dependencies bash git

# Download confd source code.
git clone --branch "${CONFD_VERSION}" https://github.com/kelseyhightower/confd.git "${confd_src_dir}"

# Build confd.
export GOPATH="${confd_src_dir}/vendor:${confd_src_dir}"
export PATH="${go_root}/bin:${PATH}"
export CGO_ENABLED=0
cd "${confd_src_dir}/src/github.com/kelseyhightower/confd"
go build -a -installsuffix nocgo .

# Install confd.
cd "${confd_src_dir}/src/github.com/kelseyhightower/confd"
install -c confd "${prefix}/bin/confd"

# Delete confd build dependencies.
apk del --purge confd-dependencies

# Remove confd source repo
rm -rf "${confd_src_dir}"
