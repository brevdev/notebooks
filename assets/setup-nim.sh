#!/bin/bash
set -euo pipefail
set -x

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
mkdir -p $LOCAL_PEFT_DIRECTORY/llama3-8b-pubmed-qa
cp ./results/Meta-Llama-3-8B-Instruct/checkpoints/megatron_gpt_peft_lora_tuning.nemo $LOCAL_PEFT_DIRECTORY/llama3-8b-pubmed-qa

# Set up NIM cache directory
mkdir -p $HOME/.nim-cache

# Set environment variables
export NIM_PEFT_SOURCE=/home/nvs/loras
export CONTAINER_NAME=meta-llama3-8b-instruct
export NIM_CACHE_PATH=$HOME/.nim-cache

# Run the Docker container
docker run -d --rm --name=$CONTAINER_NAME \
    --runtime=nvidia \
    --gpus all \
    --network=container:verb-workspace \
    --shm-size=16GB \
    -e NGC_API_KEY \
    -e NIM_PEFT_SOURCE \
    -e NIM_PEFT_REFRESH_INTERVAL \
    -v $(pwd)/workspace/loras:$NIM_PEFT_SOURCE \
    -v $HOME/.nim-cache:/home/user/.nim-cache \
    nvcr.io/nim/meta/llama3-8b-instruct:1.0.0

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