terraform {
  backend "gcs" {
    bucket = "bluf-developer"
    prefix = "infra"
  }
}