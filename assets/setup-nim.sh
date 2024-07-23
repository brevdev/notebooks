#!/bin/bash
set -euo pipefail

# Log in to NGC
echo "${NGC_API_KEY}" | docker login nvcr.io -u '$oauthtoken' --password-stdin

# Set path to your LoRA model store
export LOCAL_PEFT_DIRECTORY="$(pwd)/loras"
mkdir -p $LOCAL_PEFT_DIRECTORY
pushd $LOCAL_PEFT_DIRECTORY

# downloading NeMo-format loras from NGC
# ngc registry model download-version "nim/meta/llama3-8b-instruct-lora:nemo-math-v1"
# ngc registry model download-version "nim/meta/llama3-8b-instruct-lora:nemo-squad-v1"
popd
chmod -R 777 $LOCAL_PEFT_DIRECTORY

# copy the trained lora to the lora directory
mkdir -p $LOCAL_PEFT_DIRECTORY/llama3.1-8b-law-titlegen
cp ./results/Meta-llama3.1-8B-Instruct-titlegen/checkpoints/megatron_gpt_peft_lora_tuning.nemo $LOCAL_PEFT_DIRECTORY/llama3.1-8b-law-titlegen

# Set up NIM cache directory
mkdir -p $HOME/.nim-cache

export NIM_PEFT_SOURCE=/workspace/loras # Path to LoRA models internal to the container
export CONTAINER_NAME=meta-llama3_1-8b-instruct
export NIM_CACHE_PATH=$HOME/.nim-cache
export NIM_PEFT_REFRESH_INTERVAL=60

docker run -d --rm --name=$CONTAINER_NAME \
    --network=container:verb-workspace \
    --runtime=nvidia \
    --gpus all \
    --shm-size=16GB \
    -e NGC_API_KEY \
    -e NIM_PEFT_SOURCE \
    -e NIM_PEFT_REFRESH_INTERVAL \
    -v $HOME/.nim-cache:/home/user/.nim-cache \
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