#!/bin/bash

# Configuration
PROJECT_ID="bluf-489122"
VM_NAME="sql-bastion-bridge"
ZONE="northamerica-northeast1-a"

# Your verified Private IP
DB_PRIVATE_IP="172.20.0.3" 
LOCAL_PORT=5432

echo "--- Initializing Dev Listener ---"

# 1. Ensure Bastion VM is awake
STATUS=$(gcloud compute instances describe $VM_NAME \
    --zone=$ZONE --project=$PROJECT_ID --format='get(status)')

if [ "$STATUS" != "RUNNING" ]; then
    echo "Bastion is $STATUS. Starting it now..."
    gcloud compute instances start $VM_NAME --zone=$ZONE --project=$PROJECT_ID
fi

# 2. Start the IAP Tunnel
echo "--------------------------------------------------------"
echo "SUCCESS: Bridge Established!"
echo "Database Private IP: $DB_PRIVATE_IP"
echo "Local Listener:      localhost:$LOCAL_PORT"
echo "--------------------------------------------------------"
echo "Keep this window open. Press Ctrl+C to disconnect."

# The --quiet flag and the HostKey checking auto-accept are key for Windows/PuTTY
gcloud compute ssh $VM_NAME \
    --project=$PROJECT_ID \
    --zone=$ZONE \
    --tunnel-through-iap \
    --quiet \
    -- -L $LOCAL_PORT:$DB_PRIVATE_IP:5432 -N