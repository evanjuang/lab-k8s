# Setup `sig-storage-local-static-provisioner`
## Get source
```shell
$ wget -c https://github.com/kubernetes-sigs/sig-storage-local-static-provisioner/archive/refs/tags/v2.6.0.tar.gz \
-O - | tar xz

$ cd sig-storage-local-static-provisioner-2.6.0
```
## Default config
```shell
$ vim helm/provisioner/values.yaml 
```
```yaml
...
classes:
  - name: fast-disks 
    hostDir: /mnt/fast-disks
    volumeMode: Filesystem
    fsType: ext4
...
```
## Install
```
$ kubectl create -f \
    deployment/kubernetes/example/default_example_storageclass.yaml

$ helm template ./helm/provisioner > deployment/kubernetes/provisioner_generated.yaml
$ kubectl apply -f deployment/kubernetes/provisioner_generated.yaml
```
## Create test volume in worker
```shell
#!/bin/bash
for i in $(seq 1 3); do
    mkdir -p /mnt/fast-disks-bind/vol${i}
    mkdir -p /mnt/fast-disks/vol${i}
    mount --bind /mnt/fast-disks-bind/vol${i} /mnt/fast-disks/vol${i}
done
```