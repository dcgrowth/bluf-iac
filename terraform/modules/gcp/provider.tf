terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.17.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate
  )
}


provider "postgresql" {
  host            = var.db_host
  port            = 5432
  database        = "bluf_dlm"
  username        = var.db_user
  password        = var.db_password
  sslmode         = "disable"
  connect_timeout = 15
}