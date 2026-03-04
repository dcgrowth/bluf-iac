module "gcp" {
  source      = "./modules/gcp"
  project_id  = var.project_id
  region      = var.region
  db_host     = var.db_host
  db_user     = var.db_user
  db_password = var.db_password
}