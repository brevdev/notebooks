#!/bin/bash

# Function to check command status
check_status() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed"
        exit 1
    fi
}

echo "Setting up NVIDIA NIM operator..."

# Remove existing nvidia repo if it exists
echo "Configuring Helm repositories..."
sudo microk8s helm repo remove nvidia || true
check_status "Removing old nvidia repo"

# Add nvidia helm repo
sudo microk8s helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
check_status "Adding nvidia helm repo"

# Update helm repos
echo "Updating Helm repositories..."
sudo microk8s helm repo update
check_status "Updating helm repos"

# Create namespace for NIM operator
echo "Creating nim-operator namespace..."
sudo microk8s kubectl create namespace nim-operator
check_status "Creating namespace"

# Install NIM operator
echo "Installing NIM operator..."
sudo microk8s helm install nim-operator nvidia/k8s-nim-operator -n nim-operator
check_status "Installing NIM operator"

echo "NIM operator setup complete!"
echo "To check the status, run: sudo microk8s kubectl get pods -n nim-operator"
