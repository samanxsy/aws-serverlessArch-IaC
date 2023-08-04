# # Curated Data S3 Bucket
# # # # # # # # # # # # # #

# S3
resource "aws_s3_bucket" "curated_data_bucket" {
    bucket = "curated-data-bucket"

    tags = {
        Name = "curated-data"
    }
}

# ACL
resource "aws_s3_bucket_acl" "bucket_acl" {
    bucket = aws_s3_bucket.curated_data_bucket.id
    acl = "private"
}

# Versioning
resource "aws_s3_bucket_versioning" "versioning_curated_data_bucket" {
    bucket = aws_s3_bucket.curated_data_bucket.id

    versioning_configuration {
      status = "Enabled"
      mfa_delete = "Enabled"
    }
}

# LifeCycle
resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
    bucket = aws_s3_bucket.curated_data_bucket.id

    rule {
        id = "Archiving"
        status = "Enabled"
        transition {
            days = 100
            storage_class = "INTELLIGENT_TIERING"
        }
    }
}


# SERVER SIDE ENCRYPTION
resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
    bucket = aws_s3_bucket.curated_data_bucket.id

    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_arn
        sse_algorithm = "aws:kms"
      }
    }
}
