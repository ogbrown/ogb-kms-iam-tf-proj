variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "short_region_name" {
  description = "Short name for the region, used in resource names"
  type        = string
}

variable "another_principal" {
  description = "Another principal to add to the KMS key policy"
  type        = string
}

variable "tags" {
  type = map(string)
}

variable "general_kms_key_id" {
  description = "The KMS key ID to use for encrypting secrets"
  type        = string
  
}

variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
}

variable "aurora_short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
}

variable "aurora_cluster_identifier" {}
variable "master_user" {}

variable "db_user" {
  description = "Database user for the RDS instance"
  type        = string
}

variable "db_user_password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the database to create in the RDS instance"
  type        = string
}

variable "environment_secret_name" {
  description = "Name of the environment secret"
  type        = string
}