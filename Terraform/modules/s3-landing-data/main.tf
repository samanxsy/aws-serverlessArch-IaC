# # Landing Data S3 Bucket
# # # # # # # # # # # # # #

# S3
resource "aws_s3_bucket" "landing_data_bucket" {
  bucket = var.bucket_name
  tags = var.bucket_tags
}

# ACL
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.landing_data_bucket.id
  acl    = var.acl_state
}

# Versioning
resource "aws_s3_bucket_versioning" "versioning_landing_data_bucket" {
  bucket = aws_s3_bucket.landing_data_bucket.id

  versioning_configuration {
    status = var.versioning_status
    mfa_delete = var.mfa_status
  }
}

# LifeCycle
resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.landing_data_bucket.id

  rule {
    id     = var.lifecycle_rule_id
    status = var.lifecycle_status
    transition {
      days          = var.transition_days
      storage_class = var.transition_storage_class
    }
  }
}


# SERVER SIDE ENCRYPTION
resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
  bucket = aws_s3_bucket.landing_data_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm     = var.encryption_algorithm
    }
  }
}


# Bucket Policy for Glue
resource "aws_s3_bucket_policy" "glue_bucket_policy" {
  bucket = aws_s3_bucket.landing_data_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject"],
        Effect   = "Allow",
        Resource = "${aws_s3_bucket.landing_data_bucket.arn}/*",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}


# Bucket Policy for Glue Cataloging
resource "aws_s3_bucket_policy" "glue_catalog_bucket_policy" {
  bucket = aws_s3_bucket.landing_data_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:PutObject"], # Add "s3:PutObject" action here
        Effect   = "Allow",
        Resource = "${aws_s3_bucket.landing_data_bucket.arn}/*",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}
