
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

module "secrets" {
  source                    = "../../modules/secrets"
  aws_region                = var.aws_region
  short_region_name         = var.short_region_name
  another_principal         = var.another_principal
  short_project_name        = var.short_project_name
  aurora_short_project_name = var.aurora_short_project_name
  general_kms_key_id        = module.kms.general_kms_key_id # This is the KMS key ID output from the kms module
  aurora_cluster_identifier = "${var.aurora_short_project_name}-${var.aurora_cluster_identifier_suffix}"
  db_name                   = "${var.aurora_short_project_name}-${var.db_name_suffix}"
  db_user                   = var.db_user
  db_user_password          = var.db_user_password
  master_user               = var.master_user
  environment_secret_name   = var.environment_secret_name # Name of the environment secret
  tags                      = local.global_tags

}