#!/bin/bash
set -euo pipefail
set -x

# Set environment variables
export NIM_PEFT_SOURCE=/home/nvs/loras
export CONTAINER_NAME=meta-llama3-8b-instruct
export NIM_CACHE_PATH=$HOME/.nim-cache

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

# Log in to NGC
if [ -z "${NGC_API_KEY:-}" ]; then
    echo "NGC_API_KEY is not set. Please set it before running this script."
    exit 1
fi

# Create a temporary file to store Docker config
DOCKER_CONFIG_FILE=$(mktemp)

# Create Docker config JSON
cat > "$DOCKER_CONFIG_FILE" <<EOF
{
    "auths": {
        "nvcr.io": {
            "auth": "$(echo -n '$oauthtoken':$NGC_API_KEY | base64)"
        }
    }
}
EOF

# Use the temporary Docker config file
export DOCKER_CONFIG=$(dirname "$DOCKER_CONFIG_FILE")

echo "Successfully authenticated with NGC."

# Remove the temporary Docker config file
rm "$DOCKER_CONFIG_FILE"

# Run the Docker container
docker run -d --rm --name=$CONTAINER_NAME \
    --runtime=nvidia \
    --gpus all \
    --shm-size=16GB \
    -e NGC_API_KEY \
    -p 8000:8000 \
    -e NIM_PEFT_SOURCE \
    -e NIM_PEFT_REFRESH_INTERVAL \
    -v $HOME/.nim-cache:/home/user/.nim-cache \
    -v $HOME/.cache/huggingface:/home/user/.cache/huggingface \
    nvcr.io/nim/meta/llama3-8b-instruct:1.0.0

echo "Script execution completed."