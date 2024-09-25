#!/bin/bash
set -euo pipefail

# TODO: bail with instructions if NGC_API_KEY is not populated.

# Install Docker CLI
command -v docker > /dev/null || (
    echo "Installing Docker CLI..."
    sudo apt-get update
    sudo apt-get install -qy \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    sudo rm -f /usr/share/keyrings/docker-archive-keyring.gpg || echo
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce-cli
)

# Install NGC CLI (with suppressed output)
test -d /usr/local/ngc-cli || (
    echo "Installing NGC CLI..."
    cd /tmp
    # ensure unzip exists
    command -v unzip > /dev/null || sudo apt-get install -yq unzip
    wget -q https://api.ngc.nvidia.com/v2/resources/nvidia/ngc-apps/ngc_cli/versions/3.45.0/files/ngccli_linux.zip
    unzip -q -o ngccli_linux.zip
    sudo mv ngc-cli /usr/local/
)
# Set up Docker permissions
sudo groupadd -g 998 docker || true
sudo usermod -aG docker $USER || true
newgrp docker || true

echo "${NGC_API_KEY}" | docker login nvcr.io -u '$oauthtoken' --password-stdin