# Modules
#
# Data Storage


# # Landing data (Extreme Raw)
module "landing_data_bucket" {
  source      = "./modules/s3_bucket_module"

  # Bucket name and ACL
  bucket_name = "landing-data-bucket"
  acl_state = "private"

  # LifeCycle Configs
  lifecycle_rule_id = "Archiving"
  lifecycle_status = "Enabled"
  transition_days = "100"
  transition_storage_class = "INTELLIGENT_TIERING"

  # Versioning Configs
  versioning_status = "Enabled"
  mfa_status = "Enabled"

  # Encryption
  kms_key_arn = module.kms.kms_key_arn
  encryption_algorithm = "aws:kms"

  # Tags
  bucket_tags = {
    Name = "landing-data"
    Environment = "Dev"
  }
}


# # Raw Data (Minor processed)
module "raw_data_bucket" {
  source      = "./modules/s3_bucket_module"

  # Bucket name and ACL
  bucket_name = "raw-data-bucket"
  acl_state = "private"

  # LifeCycle Configs
  lifecycle_rule_id = "Archiving"
  lifecycle_status = "Enabled"
  transition_days = "100"
  transition_storage_class = "INTELLIGENT_TIERING"

  # Versioning Configs
  versioning_status = "Enabled"
  mfa_status = "Enabled"

  # Encryption
  kms_key_arn = module.kms.kms_key_arn
  encryption_algorithm = "aws:kms"

  # Tags
  bucket_tags = {
    Name = "raw-data"
    Environment = "Dev"
  }
}


# # Curated Data (Processed and Sanitized data)
module "curated_data_bucket" {
  source      = "./modules/s3_bucket_module"

  # Bucket name and ACL
  bucket_name = "curated-data-bucket"
  acl_state = "private"

  # LifeCycle Configs
  lifecycle_rule_id = "Archiving"
  lifecycle_status = "Enabled"
  transition_days = "100"
  transition_storage_class = "INTELLIGENT_TIERING"

  # Versioning Configs
  versioning_status = "Enabled"
  mfa_status = "Enabled"

  # Encryption
  kms_key_arn = module.kms.kms_key_arn
  encryption_algorithm = "aws:kms"

  # Tags
  bucket_tags = {
    Name = "curated-data"
    Environment = "Dev"
  }
}
