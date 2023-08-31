# Root Terraform Config
#
# Project : Data Lake Infrastructure as Code
#
# License : GNU GENERAL PUBLIC LICENSE
#
# Author : Saman Saybani


# # Modules # #

# # DATA INGESTION
module "kinesis_data_firehose" {
  source                = "./modules/kinesis_data_firehose"
  landing_s3_bucket_arn = module.landing_data_bucket.bucket_arn

  kms_key_arn = module.kms.kms_key_arn
}

module "glue_batch_ingestion" {
  source                = "./modules/glue_batch_ingestion"
  landing_s3_bucket_arn = module.landing_data_bucket.bucket_arn
  glue_db_name          = module.glue_crawler.glue_db_name
}

module "sftp" {
  source                = "./modules/sftp"
  sftp_public_key       = "SECRET/PATH"
  landing_s3_bucket_arn = module.landing_data_bucket.bucket_arn
}



# # DATA LAKE # #
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



# # DATA CATALOG & PROCCESS # #
module "glue_crawler" {
  source = "./modules/glue_crawler"
}

module "glue_catalog" {
  source       = "./modules/glue_catalog"
  glue_db_name = module.glue_crawler.glue_db_name
}

module "step_functions" {
  source                  = "./modules/step_functions"
  first_glue_crawler_arn  = module.glue_crawler.raw_data_crawler_arn
  second_glue_crawler_arn = module.glue_catalog.curated_data_table_arn
}
# # # # # # # # # # # # # # # #


# # DATA ANALYTICS # #
module "athena" {
  source = "./modules/athena"

  # # Variables
  workgroup_name          = "placeholder"
  database_name           = "placeholder"
  query_name              = "placeholder"
  athena_query            = "placeholder"
  athena_data_source_name = "placeholder"
  source_data_bucket_id   = module.curated_data_bucket.bucket_id
  s3_bucket_arn           = module.curated_data_bucket.bucket_arn
}


# module "emr" {
#   source = "./modules/emr"
# }
# # # # # # # # # # # # # # # #


# # DATA VISUALIZATION # #
module "quicksight" {
  source         = "./modules/quicksight"
  data_source_id = "data-source-ID"
  ACCOUNT_ID     = var.ACCOUNT_ID
}



# # MACHINE LEARNING # #
module "sagemaker" {
  source = "./modules/sagemaker"

  sagemaker_instance_name = "INSTANCE-NAME"
  sagemaker_instance_type = "ml.t2.medium"
  sagemaker_lifecycle_config_name = "default"
  sagemaker_tags = {
    Name = "NAME"
    Environment = "Prod"
    Project = "Project Name"
    # Add more if needed
  }

  kms_key_arn = module.kms.kms_key_arn
}
# # # # # # # # # # # # # # # #



# # KMS # #
module "kms" {
  source = "./modules/kms"
}
