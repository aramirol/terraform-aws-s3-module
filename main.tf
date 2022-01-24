# S3 Module
##################################################

# Manages a single-Region or multi-Region primary KMS key.
##################################################
resource "aws_kms_key" "kms_bucket_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = var.bucket_key_deletion_days
}

# Provides a S3 bucket resource
##################################################
resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  acl    = var.bucket_acl

  lifecycle {
    prevent_destroy = false
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.kms_bucket_key.arn
        sse_algorithm     = "aws:kms" # Also you can use AES256 without ksm_master_key_id"
      }
    }
  }

  tags = {
    Name        = var.bucket_tag_name
    Environment = var.bucket_tag_env
  }
}

# Manages S3 bucket-level Public Access Block configuration
##################################################
resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
