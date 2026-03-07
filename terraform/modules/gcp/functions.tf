resource "google_cloudfunctions2_function" "ebcdic_processor" {
  name        = "ebcdic-batch-converter"
  location    = var.region # Ensure this matches your bucket region
  description = "Converts EBCDIC directory listings to JSON for NestJS audit"

  build_config {
    runtime     = "nodejs20"
    entry_point = "processEbcdicBatch" # The function name in your index.js

    source {
      storage_source {
        bucket = "clec-inbound"
        object = "zip-box/function_code.zip"
      }
    }
  }

  service_config {
    max_instance_count = 3
    min_instance_count = 0
    available_memory   = "512Mi"
    timeout_seconds    = 540 # 9 minutes for batch processing

    # The Service Account created in your bash script
    service_account_email = "ebcdic-processor-sa@${var.project_id}.iam.gserviceaccount.com"

    environment_variables = {
      NESTJS_AUDIT_URL = "https://your-nestjs-api.com/audit"
      INBOUND_BUCKET   = "clec-inbound"
    }

    # If your NestJS/Postgres is in a VPC, uncomment this:
    vpc_connector = "projects/${var.project_id}/locations/${var.region}/connectors/my-vpc-connector"
  }
}

# Output the URL so you can put it in your Cloud Scheduler
output "function_url" {
  value = google_cloudfunctions2_function.ebcdic_processor.url
}