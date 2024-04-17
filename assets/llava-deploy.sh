#!/bin/bash

# Start the controller
python -m llava.serve.controller --host 0.0.0.0 --port 10000 &
sleep 10  # Wait longer for the controller to start

# Start the Gradio web server
python -m llava.serve.gradio_web_server --controller http://0.0.0.0:10000 --model-list-mode reload --share &
sleep 10  # Wait longer for the web server to start

# Start the first model worker
python -m llava.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40000 --worker http://localhost:40000 --model-path llava-ftmodel &
sleep 10  # Allow more time for the first worker to initialize

# Start the second model worker
python -m llava.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40001 --worker http://localhost:40001 --model-path liuhaotian/llava-v1.5-13b &

# Optionally, wait for all background processes to finish
wait

