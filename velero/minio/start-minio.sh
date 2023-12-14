#!/bin/bash

curdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
datadir="$curdir"/data

mkdir -p "$datadir"

docker run --name minio \
    -p 9000:9000 \
    -p 9999:9999 \
    -d --restart=always \
    -e "MINIO_ROOT_USER=admin" \
    -e "MINIO_ROOT_PASSWORD=12345678" \
    -v $datadir:/data \
    minio/minio:RELEASE.2023-08-31T15-31-16Z server /data --console-address '0.0.0.0:9999'
