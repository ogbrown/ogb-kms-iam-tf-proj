data "aws_caller_identity" "current" {}
resource "aws_kms_key" "secret_key" {
  description         = "General KMS key for encrypting and decrypting"
  deletion_window_in_days = 20
  tags                = var.tags
}

resource "aws_kms_alias" "secret_key_alias" {
  name          = "alias/${var.short_project_name}-${var.short_region_name}" # Replace with your alias name
  target_key_id = aws_kms_key.secret_key.id
}

resource "aws_kms_key_policy" "secret_key_policy" {
  key_id = aws_kms_key.secret_key.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = [ "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
                  "arn:aws:iam::${data.aws_caller_identity.current.account_id}:${var.another_principal}"
                ]
        },
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}