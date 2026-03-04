#!/bin/bash

# Set your variables
PROJECT_ID="bluf-489122"
SA_EMAIL="bluf-postgre@${PROJECT_ID}.iam.gserviceaccount.com"

# Grant Network permissions
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA_EMAIL" \
    --role="roles/compute.networkAdmin"

# Grant SQL permissions
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA_EMAIL" \
    --role="roles/cloudsql.admin"

# Grant Private Service Access permissions (for Private IP)
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA_EMAIL" \
    --role="roles/servicenetworking.networksAdmin"

# Grant Storage permissions (to read/write the Terraform State file)
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA_EMAIL" \
    --role="roles/storage.objectAdmin"