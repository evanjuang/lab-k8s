# Test Envirionment
- host
    - IP: 192.168.122.1
    - install `docker`
    - install `kubectl`
- k8s
    - `vagrant/multi-node`

# Setup minio
1. Run minio by docker
    - `minio/start-minio.sh`
2. connect to minio web (http://localhost:9999)
    - create bucket `velerodata`
# Install velero
1. download velero binary
    ```
    $ wget https://github.com/vmware-tanzu/velero/releases/download/v1.10.2/velero-v1.10.2-linux-amd64.tar.gz
    $ tar zxf velero-v1.10.2-linux-amd64.tar.gz 
    $ mv velero-v1.10.2-linux-amd64/velero /usr/local/bin/
    ```
2. install velero (default namespace is `velero`)
    - `bash velero-install.sh`
3. verify
    ```
    $ kubectl logs deployment/velero -n velero
    $ velero backup-location get
    ```
4. uninstall
    ```
    $ kubectl delete namespace/velero clusterrolebinding/velero
    $ kubectl delete crds -l component=velero
    ```
# Test: backup and restore for specific namespace
1. create test pod
    ```
    $ kubectl apply -f velero-v1.10.2-linux-amd64/examples/nginx-app/base.yaml 
    ```
2. backup
    ```
    $ velero backup create nginx-backup --include-namespaces nginx-example
    $ velero backup get
    $ velero backup describe nginx-backup
    $ velero backup logs nginx-backup
    ```
3. restore
    ```
    $ velero backup get
    $ velero restore create --from-backup nginx-backup
    $ velero restore get
    $ velero restore describe nginx-backup-xxxxxxxxx
    ```