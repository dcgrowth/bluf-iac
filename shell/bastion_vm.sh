#!/bin/bash

# Configuration
PROJECT_ID="bluf-489122"
ZONE="northamerica-northeast1-a"
SUBNET="bluf-subnet-northamerica-northeast1"
VM_NAME="sql-bastion-bridge"

echo "Step 1: Handling IAP Firewall Rule..."
# Check if the rule exists; if not, create it
if ! gcloud compute firewall-rules describe allow-ssh-ingress-from-iap --project=$PROJECT_ID >/dev/null 2>&1; then
    gcloud compute firewall-rules create allow-ssh-ingress-from-iap \
        --project=$PROJECT_ID \
        --network=bluf-vpc \
        --allow=tcp:22 \
        --source-ranges=35.235.240.0/20 \
        --description="Allow IAP Tunneling"
else
    echo "Firewall rule already exists, skipping..."
fi

echo "Step 2: Creating Bastion VM in $SUBNET..."
# Removed --maintenance-policy=TERMINATE as e2 instances use MIGRATE by default
gcloud compute instances create $VM_NAME \
    --project=$PROJECT_ID \
    --zone=$ZONE \
    --machine-type=e2-small \
    --subnet=$SUBNET \
    --no-address \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --tags=bastion-ssh

echo "Setup Complete. Your Bastion is ready."
