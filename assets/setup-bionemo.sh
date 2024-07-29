#!/bin/bash
set -euo pipefail

# Log in to NGC
echo "${NGC_API_KEY}" | docker login nvcr.io -u '$oauthtoken' --password-stdin

# Set up directories
export BIONEMO_HOME="/workspace/bionemo"
mkdir -p $BIONEMO_HOME

# Pull BioNeMo container from NGC
export BIONEMO_CONTAINER="nvcr.io/nvidia/clara/bionemo-framework:1.4"
docker pull $BIONEMO_CONTAINER

# Set up environment variables
export CONTAINER_NAME=bionemo-container

# Run BioNeMo container
docker run -d --rm --name=$CONTAINER_NAME \
    --network=container:verb-workspace \
    --runtime=nvidia \
    --gpus all \
    -e NGC_API_KEY \
    -v /home/ubuntu/workspace:/workspace \
    -w /workspace \
    $BIONEMO_CONTAINER

# Check if BioNeMo is up
echo "Checking if BioNeMo is up..."
while true; do
    if docker exec $CONTAINER_NAME python -c "import bionemo" &> /dev/null; then
        echo "BioNeMo has been started successfully!"
        break
    else
        echo "BioNeMo is not up yet. Checking again in 10 seconds..."
        sleep 10
    fi
done

# Copy BioNeMo code to workspace (if needed)
docker cp $CONTAINER_NAME:/opt/nvidia/bionemo $BIONEMO_HOME

echo "BioNeMo setup complete. You can now run your BioNeMo workflows."