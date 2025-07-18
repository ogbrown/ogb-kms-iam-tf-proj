locals {
  raw_string = var.db_name
  parts = split("-", local.raw_string)
  remaining_parts = concat([lower(local.parts[0])],[for p in slice(local.parts, 1, length(local.parts)) : title(lower(p))])
  db_name = join("", local.remaining_parts)
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()-_=+[]{}<>?~" # Specify valid special characters
}

resource "aws_secretsmanager_secret" "aurora_db_master_secret" {
  name = "${var.aurora_cluster_identifier}-secret"
  description = "Master credentials for Aurora PostgreSQL"
  kms_key_id                  = var.general_kms_key_id
}

resource "aws_secretsmanager_secret_version" "aurora_db_master_secret_version" {
  secret_id     = aws_secretsmanager_secret.aurora_db_master_secret.id
  secret_string = jsonencode({
    username = var.master_user
    password = random_password.db_password.result
  })
}

resource "aws_secretsmanager_secret" "aurora_db_user_secret" {
  name = "${var.environment_secret_name}"
  description = "User credentials for Aurora PostgreSQL"
  kms_key_id                  = var.general_kms_key_id
}

resource "aws_secretsmanager_secret_version" "aurora_db_user_secret_version" {
  secret_id     = aws_secretsmanager_secret.aurora_db_user_secret.id
  secret_string = jsonencode({
    "spring.datasource.username" : var.db_user
    "spring.datasource.password" : var.db_user_password
    "spring.datasource.url": "jdbc:postgresql://TBD:5432/${local.db_name}"
  })
}

# resource "aws_secretsmanager_secret" "update_local_dev" {
#   name                        = "local/dev"
#   kms_key_id                  = var.general_kms_key_id
#   force_overwrite_replica_secret = true
# }

# resource "aws_secretsmanager_secret" "update_db_secret" {
#   name                        = "ogb-aurora-lowcost-dev-v2-secret"
#   kms_key_id                  = var.general_kms_key_id
#   force_overwrite_replica_secret = true
# }

# resource "aws_secretsmanager_secret" "delete_local_dev" {
#   name = "local/dev"

#   lifecycle {
#     prevent_destroy = false
#   }
# }

# resource "aws_secretsmanager_secret" "delete_ogb_aurora_lowcost_dev_v2_secret" {
#   name = "ogb-aurora-lowcost-dev-v2-secret"

#   lifecycle {
#     prevent_destroy = false
#   }
# }
