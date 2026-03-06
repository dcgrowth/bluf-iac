resource "google_storage_bucket" "inbound_bucket" {
  name                        = "clec-inbound"
  location                    = var.region
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy               = true # Set to false in production to prevent data loss
}