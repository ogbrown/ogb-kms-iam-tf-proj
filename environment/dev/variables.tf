variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"

}

variable "short_region_name" {
  description = "Short name for the region, used in resource names"
  type        = string
}

variable "another_principal" {
  description = "Another principal to add to the KMS key policy"
  type        = string
}

variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
}

variable "tags" {
  type = map(string)
}

