resource "aws_s3_bucket" "storage-code-lambda" {
  depends_on = [aws_kms_key.kms]
  bucket     = "storage-code-lambda-dev"
}

resource "aws_s3_bucket_versioning" "storage-code-lambda" {
  bucket = aws_s3_bucket.storage-code-lambda.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "storage-code-lambda" {
  bucket = aws_s3_bucket.storage-code-lambda.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.kms.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_acl" "storage-code-lambda" {
  bucket = aws_s3_bucket.storage-code-lambda.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "storage-code-lambda" {
  bucket                  = aws_s3_bucket.storage-code-lambda.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "storage-code-lambda-log-bucket-dev" {
  depends_on = [aws_kms_key.kms]
  bucket     = "storage-code-lambda-log-bucket-dev"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "storage-code-lambda-log-bucket-dev" {
  bucket = aws_s3_bucket.storage-code-lambda-log-bucket-dev.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.kms.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "storage-code-lambda-log-bucket-dev" {
  bucket = aws_s3_bucket.storage-code-lambda-log-bucket-dev.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "storage-code-lambda-log-bucket-dev" {
  bucket                  = aws_s3_bucket.storage-code-lambda-log-bucket-dev.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "storage-code-lambda-log-bucket-dev" {
  bucket = aws_s3_bucket.storage-code-lambda-log-bucket-dev.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "storage-code-lambda-log-bucket-dev" {
  bucket = aws_s3_bucket.storage-code-lambda.id

  target_bucket = aws_s3_bucket.storage-code-lambda-log-bucket-dev.id
  target_prefix = "log/"
}
