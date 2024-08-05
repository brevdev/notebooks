#!/bin/bash
set -euo pipefail

newgrp docker
id

# Log in to NGC
echo "${NGC_API_KEY}" | docker login nvcr.io -u '$oauthtoken' --password-stdin

# Choose a container name for bookkeeping
export NIM_MODEL_NAME=nvidia/nv-rerankqa-mistral-4b-v3
export CONTAINER_NAME=$(basename $NIM_MODEL_NAME)

# Choose a NIM Image from NGC
export IMG_NAME="nvcr.io/nim/$NIM_MODEL_NAME:1.0.0"

# Choose a path on your system to cache the downloaded models
export LOCAL_NIM_CACHE=~/.cache/nim
mkdir -p "$LOCAL_NIM_CACHE"

docker run -d --rm --name=$CONTAINER_NAME \
    --network=container:verb-workspace \
    --runtime=nvidia \
    --gpus all \
    --shm-size=16GB \
    -e NGC_API_KEY \
    -v $HOME/.nim-cache:/opt/nim/.nim-cache \
    -u $(id -u) \
    -p 8000:8000 \
    $IMG_NAME

# Check if NIM is up
echo "Checking if NIM is up..."
while true; do
    if curl -s http://localhost:8000 > /dev/null; then
        echo "NIM has been started successfully!"
        break
    else
        echo "NIM is not up yet. Checking again in 10 seconds..."
        sleep 10
    fi
done
