resource "aws_secretsmanager_secret" "update_local_dev" {
  name      = "local/dev"
  kms_key_id = general_kms_key_id
}


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
