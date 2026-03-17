#!/bin/bash
# Apply variables to the current environment
export HTTP_PROXY="http://your.proxy:8080"
export HTTPS_PROXY="http://your.proxy:8080"

echo "Proxy is ACTIVE. Closing this script (Ctrl+C) will unset them."

# Trap the exit signal (Ctrl+C)
trap 'unset HTTP_PROXY; unset HTTPS_PROXY; echo "Proxy removed."; exit' INT

# Keep the script alive
while true; do sleep 1; done