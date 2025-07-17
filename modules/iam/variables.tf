variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "short_region_name" {
  description = "Short name for the region, used in resource names"
  type        = string
}

variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
}

variable "tags" {
  type = map(string)
}