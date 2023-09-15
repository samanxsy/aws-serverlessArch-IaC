# Root Terraform Config
#
# Project : Data Lake Infrastructure as Code
#
# License : GNU GENERAL PUBLIC LICENSE
#
# Author : Saman Saybani


# # Encryption
module "kms" {
  source = "./modules/kms"
}


# # Policies
module "s3_bucket_policies" {
  source = "./policies/s3_policies"

  # Curated Data Bucket Info
  curated_data_bucket_id = module.curated_data_bucket.bucket_id
  curated_data_bucket_arn = module.curated_data_bucket.bucket_arn

  # Raw Data Bucket info
  raw_data_bucket_id = module.raw_data_bucket.bucket_id
  raw_data_bucket_arn = module.raw_data_bucket.bucket_arn

  # Landing Data Bucket Info
  landing_data_bucket_id = module.landing_data_bucket.bucket_id
  landing_data_bucket_arn = module.landing_data_bucket.bucket_arn
}

module "athena_policies" {
  source = "./policies/athena_policies"
  
  s3_bucket_arn = module.curated_data_bucket.bucket_arn
}


# # ROLES # #
module "iam_roles" {
  source = "./modules/iam_roles"
}
