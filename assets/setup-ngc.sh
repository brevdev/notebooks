#!/bin/bash
set -euo pipefail

# Install Docker CLI
echo "Installing Docker CLI..."
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce-cli
# Install NGC CLI (with suppressed output)
echo "Installing NGC CLI..."
(
    cd /tmp
    wget -q https://api.ngc.nvidia.com/v2/resources/nvidia/ngc-apps/ngc_cli/versions/3.45.0/files/ngccli_linux.zip
    unzip -q -o ngccli_linux.zip
    sudo mv ngc-cli /usr/local/ 2>/dev/null
) >/dev/null 2>&1
# Set up Docker permissions
sudo groupadd -g 999 docker || true
sudo usermod -aG docker $USER
# Set up NIM cache directory
mkdir -p $HOME/.nim-cache
# Print message before downloading .nemo model
echo "Downloading .nemo model. This might take a few minutes..."
# Download .nemo model from ngc
/usr/local/ngc-cli/ngc registry model download-version "nvidia/nemo/llama-3_1-8b-instruct-nemo:1.0" > ngc_output.log 2>&1
echo "Script execution completed."