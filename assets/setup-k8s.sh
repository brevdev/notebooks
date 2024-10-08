#!/bin/bash

# Install microk8s
sudo snap install microk8s --classic --channel=1.25/stable
sudo usermod -a -G microk8s $USER
mkdir -p ~/.kube
chmod 0700 ~/.kube

# Enable GPU and storage
sudo microk8s enable gpu hostpath-storage
sudo microk8s status --wait-ready

# Set up kubectl alias
echo "alias kubectl='microk8s kubectl'" >> ~/.bashrc

# Enable and set up Helm
microk8s enable helm3
echo "alias helm='microk8s helm3'" >> ~/.bashrc

# Update Helm repos
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm repo add nvidia https://helm.ngc.nvidia.com/nvidia && helm repo update

# Set up NIM operator
kubectl create namespace nim-operator

# Create NGC secret (NGC_API_KEY should be passed as an argument)
kubectl create secret -n nim-operator docker-registry ngc-secret \
    --docker-server=nvcr.io \
    --docker-username='$oauthtoken' \
    --docker-password=$NGC_API_KEY

# Install NIM operator
helm install nim-operator nvidia/k8s-nim-operator -n nim-operator

# Check NIM operator status
kubectl get pods -n nim-operator

# Output success message
echo "Notebook now has k8s/helm support and NIM operator"
