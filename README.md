## Install Vagrant
- kvm
    ```shell
    dnf install qemu-kvm libvirt virt-install
    ```
- vagrant
- vagrant-libvirt
    ```
    vagrant plugin install vagrant-libvirt
    ```
## Enable NFS in Host
```shell
dnf install nfs-utils && sudo systemctl enable nfs-server
```
```shell
firewall-cmd --permanent --zone=libvirt --add-service=nfs3  \
   && firewall-cmd --permanent --zone=libvirt --add-service=nfs \
   && firewall-cmd --permanent --zone=libvirt --add-service=rpc-bind \
   && firewall-cmd --permanent --zone=libvirt --add-service=mountd \
   && sudo firewall-cmd --reload
```
## Execute
- Update IP
    - `scripts/master.sh`
        ```
        MASTER_IP="192.168.121.220"
        ```
- Create k8s cluster
    ```
    vagrant up --provider=libvirt
    ```
- Copy kubeconfig to host
    ```
    mkdir ~/.kube
    cp ./configs/config  ~/.kube/
    ```
