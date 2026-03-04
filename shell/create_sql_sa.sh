#!/bin/bash

# --- Variables ---
SA_NAME="bluf-postgre"
PROJECT_ID=$(gcloud config get-value project)
SA_EMAIL="${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

echo "Using Project ID: $PROJECT_ID"

# 1. Create the Service Account
echo "Creating service account: $SA_NAME..."
gcloud iam service-accounts create $SA_NAME \
    --description="Service account for Cloud SQL administration and connectivity" \
    --display-name="Bluf Postgre SA"

# Small sleep to allow IAM eventual consistency
sleep 5

# 2. Add Cloud SQL Admin Role
echo "Assigning Cloud SQL Admin role..."
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA_EMAIL" \
    --role="roles/cloudsql.admin"

# 3. Add Cloud SQL Client Role
echo "Assigning Cloud SQL Client role..."
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA_EMAIL" \
    --role="roles/cloudsql.client"

echo "------------------------------------------------"
echo "Setup Complete!"
echo "Service Account: $SA_EMAIL"