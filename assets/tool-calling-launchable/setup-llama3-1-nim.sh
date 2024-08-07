#!/bin/bash
set -euo pipefail
set -x

mkdir -p $HOME/.nim-cache

export CONTAINER_NAME=meta-llama3_1-8b-instruct
export NIM_CACHE_PATH=$HOME/.nim-cache

export LOCAL_NIM_CACHE=~/.cache/nim
mkdir -p "$LOCAL_NIM_CACHE"
docker run -d --rm --name=$CONTAINER_NAME \
    --network=container:verb-workspace \
    --runtime=nvidia \
    --gpus all \
    --shm-size=16GB \
    -e NGC_API_KEY \
    -v $NIM_CACHE_PATH:/home/user/.nim-cache \
    -v /home/ubuntu/workspace:/workspace \
    -w /workspace \
    nvcr.io/nim/meta/llama-3.1-8b-instruct:1.1.0

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