#!/bin/bash
# Function to check command status
check_status() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed"
        exit 1
    fi
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if nvidia-smi is available
echo "Checking NVIDIA GPU..."
if ! command_exists nvidia-smi; then
    echo "Warning: nvidia-smi not found. GPU support may not be available."
else
    nvidia-smi
    check_status "nvidia-smi"
fi

# Install MicroK8s
echo "Installing MicroK8s..."
sudo snap install microk8s --classic --channel=1.25/stable
check_status "MicroK8s installation"

# Add user to microk8s group
echo "Adding user to microk8s group..."
sudo usermod -a -G microk8s $USER
check_status "Adding user to microk8s group"

# Create and set permissions for .kube directory
echo "Setting up .kube directory..."
mkdir -p ~/.kube
chmod 0700 ~/.kube
sudo chown -f -R $USER ~/.kube
check_status "Setting up .kube directory"

# Wait for MicroK8s to be ready
echo "Waiting for MicroK8s to be ready..."
sudo microk8s status --wait-ready
check_status "MicroK8s ready check"

# Enable GPU and storage support
echo "Enabling GPU and hostpath-storage..."
sudo microk8s enable gpu hostpath-storage
check_status "Enabling MicroK8s addons"

# Double check status
echo "Checking final MicroK8s status..."
sudo microk8s status --wait-ready
check_status "Final MicroK8s status check"

# Source the files to make aliases available immediately
source ~/.bashrc
source /etc/bash.bashrc

# Set up Helm repositories
echo "Setting up Helm repositories..."
sudo microk8s helm repo remove nvidia || true  # Remove if exists
sudo microk8s helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
sudo microk8s helm repo update

# Activate the new group membership without requiring logout
echo "Activating microk8s group membership..."
if ! groups | grep -q microk8s; then
    exec sg microk8s -c '
        echo "Testing cluster access..."
        sudo microk8s kubectl get services
        sudo microk8s kubectl get nodes
        echo "Creating example nginx deployment..."
        sudo microk8s kubectl create deployment nginx --image=nginx
        echo "Checkisng pods..."
        sudo microk8s kubectl get pods
        echo "The kubectl and helm aliases are now active globally."
    '
else
    echo "Testing cluster access..."
    sudo microk8s kubectl get services
    sudo microk8s kubectl get nodes
    echo "Creating example nginx deployment..."
    sudo microk8s kubectl create deployment nginx --image=nginx
    echo "Checking pods..."
    sudo microk8s kubectl get pods
fi

echo "Logging into NGC using your API Key"
sudo microk8s kubectl create secret -n nim-operator docker-registry ngc-secret \
    --docker-server=nvcr.io \
    --docker-username='$oauthtoken' \
    --docker-password=$NGC_API_KEY

echo "Setup of (Micro)K8s is complete. Let it rip!!🤙"
