
locals {
  global_tags = merge(
    var.tags,
    {
      LastApplied = timestamp()
    }
  )
}
data "aws_caller_identity" "current" {}

module "iam" {
  source             = "../../modules/iam"
  aws_region         = var.aws_region
  short_region_name  = var.short_region_name
  short_project_name = var.short_project_name
  tags               = local.global_tags
}

module "kms" {
  source             = "../../modules/kms"
  aws_region         = var.aws_region
  short_region_name  = var.short_region_name
  another_principal  = var.another_principal
  short_project_name = var.short_project_name
  tags               = local.global_tags
}