resource "aws_kms_key" "kms" {
  description = "KMS utilizada no bucket de storage-code-lambda"
  enable_key_rotation = true
}