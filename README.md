# CentOS
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
# Ubuntu (22.04)
## Install Vagrant
- qemu-kvm libvirt
- vagrant
    ```shell
    wget https://releases.hashicorp.com/vagrant/2.3.6/vagrant_2.3.6-1_amd64.deb
    dpkg -i vagrant_2.3.6-1_amd64.deb
    ```
- vagrant-libvirt
    ```shell
    sudo cp /etc/apt/sources.list /etc/apt/sources.list."$(date +"%F")"
    sudo sed -i -e '/^# deb-src.*universe$/s/# //g' /etc/apt/sources.list
    sudo apt-get -y build-dep ruby-libvirt
    sudo apt-get -y install ebtables dnsmasq-base
    sudo apt-get -y install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev
    vagrant plugin install vagrant-libvirt
    ```
## Enable NFS
    ```shell
    sudo apt-get -y install nfs-kernel-server
    sudo systemctl enable --now nfs-server
    ufw allow nfs
    ```
# Create Cluster
- Update IP
    - `scripts/master.sh`
        ```
        MASTER_IP="192.168.121.220"
        ```
- Create k8s cluster
    ```
    vagrant up k8s-master --provider=libvirt
    vagrant up k8s-worker1 --provider=libvirt
    ```
- Copy kubeconfig to host
    ```
    mkdir ~/.kube
    cp ./configs/config  ~/.kube/
    ```
