#!/bin/sh

case $TARGETARCH in
  "amd64")
    echo "x86_64" > /.protoc_arch
    ;;
  "arm64")
    echo "aarch_64" > /.protoc_arch
    ;;
  *)
    echo "unsupported: TARGETARCH=${TARGETARCH}"
    exit 1
esac
