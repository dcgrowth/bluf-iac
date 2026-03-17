# 1. The VPC Network
resource "google_compute_network" "bluf_vpc" {
  name                    = "bluf-vpc"
  auto_create_subnetworks = false
}

# # 2. A Subnet (Where your App/VMs will live)
# resource "google_compute_subnetwork" "bluf_subnet" {
#   name          = "bluf-subnet-northamerica-northeast1"
#   ip_cidr_range = "10.0.1.0/24"
#   region        = "northamerica-northeast1"
#   network       = google_compute_network.bluf_vpc.id
# }

# # 3. Reserve the Internal IP Range for Google Services
# # This is the "pool" Cloud SQL will pull its Private IP from.
# resource "google_compute_global_address" "private_ip_alloc" {
#   name          = "google-managed-services-bluf-vpc"
#   purpose       = "VPC_PEERING"
#   address_type  = "INTERNAL"
#   prefix_length = 16
#   network       = google_compute_network.bluf_vpc.id
# }

# # 4. Create the Private Connection (VPC Peering)
# # This enables the "Private IP" magic.
# resource "google_service_networking_connection" "private_vpc_connection" {
#   network                 = google_compute_network.bluf_vpc.id
#   service                 = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
# }

# ---------------------------------------------------------
# PLACEHOLDER: YOUR MANUAL INSTANCE
# ---------------------------------------------------------
# Note: Since your instance is manual, ensure its 
# "Private Network" setting in the Console is pointed to 
# the VPC created above (bluf-vpc).
# ---------------------------------------------------------

# Optional: Create a DB inside your manual instance via TF
# resource "google_sql_database" "database" {
#   name     = "bluf_db"
#   instance = "YOUR_MANUAL_INSTANCE_NAME_HERE"
# }