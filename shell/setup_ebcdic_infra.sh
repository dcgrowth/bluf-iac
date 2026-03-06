#!/bin/bash

# Configuration - Replace these with your actual values
PROJECT_ID="bluf-489122"
REGION="northamerica-northeast1"
FUNCTION_SA_NAME="ebcdic-processor-sa"
SCHEDULER_SA_NAME="ebcdic-scheduler-sa"

# 1. Set the project context
gcloud config set project $PROJECT_ID

echo "Enabling Google Cloud APIs..."
# 2. Enable Required APIs
gcloud services enable \
  cloudfunctions.googleapis.com \
  run.googleapis.com \
  cloudbuild.googleapis.com \
  artifactregistry.googleapis.com \
  cloudscheduler.googleapis.com \
  storage-api.googleapis.com \
  iam.googleapis.com

echo "Creating Service Accounts..."
# 3. Create Service Account for the Cloud Function
gcloud iam service-accounts create $FUNCTION_SA_NAME \
    --display-name="EBCDIC Processor SA"

# 4. Create Service Account for Cloud Scheduler
gcloud iam service-accounts create $SCHEDULER_SA_NAME \
    --display-name="EBCDIC Scheduler SA"

echo "Assigning IAM Roles to Function SA..."
# 5. Assign Storage and Logging roles to the Function
# Role: Read from BucketA, Write to BucketB
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$FUNCTION_SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/storage.objectUser"

# Role: Write logs
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$FUNCTION_SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/logging.logWriter"

# Role: Required for 2nd Gen functions to pull images
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$FUNCTION_SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/artifactregistry.reader"

echo "Assigning Invoker Role to Scheduler SA..."
# 6. Allow Scheduler to invoke Cloud Run (2nd Gen Functions)
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SCHEDULER_SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/run.invoker"

echo "Infrastructure setup complete!"