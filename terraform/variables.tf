variable "project_id" {
  type        = string
  default     = "bluf-489122"
  description = "project to deploy java springboot cloud-dev demo resources"
}

variable "region" {
  type        = string
  default     = "northamerica-northeast1"
  description = "Region to deploy java springboot cloud-dev demo resources"
}

variable "db_user" {
  type        = string
  description = "Database user for the Spring Boot application"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Database password for the Spring Boot application"
}



