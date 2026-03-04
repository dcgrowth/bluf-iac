variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "project_id" {
  type        = string
  description = "project to deploy resources"
}
variable "region" {
  type        = string
  description = "Region to deploy resources"
}

