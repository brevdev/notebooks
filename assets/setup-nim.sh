#!/bin/bash
set -euo pipefail
set -x

# Log in to NGC
echo "${NGC_API_KEY}" | docker login nvcr.io -u '$oauthtoken' --password-stdin

# Set up NIM cache directory
mkdir -p $HOME/.nim-cache

# Set environment variables
export NIM_PEFT_SOURCE=/home/nvs/loras
export CONTAINER_NAME=meta-llama3-8b-instruct
export NIM_CACHE_PATH=$HOME/.nim-cache

# Run the Docker container
docker run -d --rm --name=$CONTAINER_NAME \
    --gpus all \
    --network=container:verb-workspace \
    --shm-size=16GB \
    -e NGC_API_KEY \
    -e NIM_PEFT_SOURCE \
    -e NIM_PEFT_REFRESH_INTERVAL \
    -v $HOME/.nim-cache:/home/user/.nim-cache \
    -v $HOME/.cache/huggingface:/home/user/.cache/huggingface \
    nvcr.io/nim/meta/llama3-8b-instruct:1.0.0