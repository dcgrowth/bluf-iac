
variable "project_id" {
  type        = string
  description = "project to deploy resources"
}
variable "region" {
  type        = string
  description = "Region to deploy resources"
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_host" {
  type        = string
  description = "Database host IP address"
}
