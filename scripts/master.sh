#! /bin/bash

MASTER_IP="192.168.121.220"
NODENAME=$(hostname -s)
SERVICE_CIDR="10.96.0.0/12"
POD_CIDR="10.244.0.0/16"
KUBE_VERSION=v1.21.1

# kubeadm init
sudo kubeadm init \
  --kubernetes-version=$KUBE_VERSION \
  --apiserver-advertise-address=$MASTER_IP \
  --service-cidr=$SERVICE_CIDR \
  --pod-network-cidr=$POD_CIDR \
  --node-name=$NODENAME \
  --ignore-preflight-errors=Swap

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# save configs
config_path="/vagrant/configs"

if [ -d $config_path ]; then
   sudo rm -f $config_path/*
else
   sudo mkdir -p $config_path
fi

sudo cp -i /etc/kubernetes/admin.conf $config_path/config
sudo touch $config_path/join.sh
sudo chmod +x $config_path/join.sh

kubeadm token create --print-join-command > $config_path/join.sh

# install calico network plugin
sudo wget https://docs.projectcalico.org/manifests/calico.yaml
sudo kubectl apply -f calico.yaml

sudo -i -u vagrant bash << EOF
mkdir -p /home/vagrant/.kube
sudo cp -i /vagrant/configs/config /home/vagrant/.kube/
sudo chown 1000:1000 /home/vagrant/.kube/config
EOF
