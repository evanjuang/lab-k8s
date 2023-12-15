#!/bin/bash

velero install \
  --provider aws \
  --plugins velero/velero-plugin-for-aws:v1.6.0,velero/velero-plugin-for-csi:v0.4.3 \
  --bucket velerodata \
  --secret-file ./velero-auth.txt \
  --use-node-agent \
  --use-volume-snapshots=true \
  --namespace velero \
  --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://192.168.122.1:9000 \
  --snapshot-location-config region=default \
  --features=EnableCSI \
  --wait
