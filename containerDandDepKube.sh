#!/bin/bash

#This script for all nodes

# update APT Packages
sudo apt-get update
####################################################################################################################

# Allow APT to use HTTPS
sudo apt install apt-transport-https curl -y
####################################################################################################################
# uprade APT Packages
sudo apt-get upgrade -y

####################################################################################################################

# install containerD
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install containerd.io -y
#####################################################################################################################

#create the containerd configuration file using the following commands:
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

#Edit /etc/containerd/config.toml
# Define the key and the new value
key="SystemdCgroup"
new_value="true"
sfile="/etc/containerd/config.toml"

    if grep -qi "^\s*${key}\s*=" "${sfile}"; then
        echo "The key is exist"
        sudo sed -i "s/^\(\s*${key}\s*=\s*\).*$/\1${new_value}/I" "${sfile}"
    else
        echo "the file is not exist"
       # echo "${key}=${new_value}" | sudo tee -a "${sfile}"
    fi
# Restart containerd:
sudo systemctl restart containerd
####################################################################################################################

#To disable swap on all the nodes using the following command.
sudo swapoff -a
(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true
#The fstab entry will make sure the swap is off on system reboots.
####################################################################################################################

#Enable kernel modules
sudo modprobe br_netfilter
echo "install modprobe"
#Add some settings to sysctl
sudo sysctl -w net.ipv4.ip_forward=1
####################################################################################################################
# This script for all nodes

# update APT Packages
sudo apt-get update
####################################################################################################################

# Add the new repository key:
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg

# Add the new repository:
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Install Kubernetes Components (kubelet, kubeadm, and kubectl):

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
