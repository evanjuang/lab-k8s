# Install Snapshot Controller
>  VolumeSnapshotContent ==> PV <br>
>  VolumeSnapshot ==> PVC <br>
>  VolumeSnapshotClass ==> StorageClass <br>
>  [ref](https://medium.com/@duan.li/%E9%AD%94%E7%8D%B8%E4%B8%96%E7%95%8C%E7%95%AA%E5%A4%96%E7%AF%87-%E7%84%A1%E7%AA%AE%E7%9B%A1%E7%9A%84%E5%89%AF%E6%9C%AC-volume-snapshot-580cff7f8cf7)

1. install k8s crd 
    ```
    $ git clone https://github.com/kubernetes-csi/external-snapshotter.git
    $ cd external-snapshotter/
    $ kubectl kustomize client/config/crd | kubectl create -f -
    $ kubectl -n kube-system kustomize deploy/kubernetes/snapshot-controller | kubectl create -f -
    ```
2. install rook SnapshotClass (`rook/deploy/examples/csi/rbd`)
    ```yaml
    ---
    apiVersion: snapshot.storage.k8s.io/v1
    kind: VolumeSnapshotClass
    metadata:
    name: csi-rbdplugin-snapclass
    labels:
        velero.io/csi-volumesnapshot-class: "true"
    driver: rook-ceph.rbd.csi.ceph.com # driver:namespace:operator
    parameters:
    # Specify a string that identifies your cluster. Ceph CSI supports any
    # unique string. When Ceph CSI is deployed by Rook use the Rook namespace,
    # for example "rook-ceph".
    clusterID: rook-ceph # namespace:cluster
    csi.storage.k8s.io/snapshotter-secret-name: rook-csi-rbd-provisioner
    csi.storage.k8s.io/snapshotter-secret-namespace: rook-ceph # namespace:cluster
    deletionPolicy: Retain
    ```
