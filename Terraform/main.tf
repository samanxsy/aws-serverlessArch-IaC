# # Root Main Terraform File
# # # # # # # # # # # # # # #

# # Data Lake Infrastructure as Code
# # # # # # # # # # # # # # # # # # #


# # Terraform State
terraform {
  backend "remote" {
    organization = "vx_data_lake"

    workspaces {
      name = "data-lake-iac"
    }
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}
# # # # # # # # # # # # # # # #


# # Modules
# # # # # #

# # DATA INGESTION # #
module "kinesis-data-firehose" {
  source = "./modules/kinesis-data-firehose"
  landing_s3_bucket_arn = module.s3-landing-data.landing_s3_bucket_arn

  kms_key_arn = module.kms.kms_key_arn
}

module "glue-batch-ingestion" {
  source = "./modules/glue-batch-ingestion"
  landing_s3_bucket_arn = module.s3-landing-data.landing_s3_bucket_arn
}

module "sftp" {
  source = "./modules/sftp"
}
# # # # # # # # # # # # # # # #



# # DATA LAKE # #
module "s3-landing-data" {
  source = "./modules/s3-landing-data"
  kms_key_arn = module.kms.kms_key_arn
}

module "s3-raw-data" {
  source = "./modules/s3-raw-data"
  kms_key_arn = module.kms.kms_key_arn
}

module "s3-curated-data" {
  source = "./modules/s3-curated-data"
  kms_key_arn = module.kms.kms_key_arn
}
# # # # # # # # # # # # # # # #



# # DATA ANALYTICS # #
module "athena" {
  source = "./modules/athena"

  # # Variables
  workgroup_name = "placeholder"
  database_name = "placeholder"
  query_name = "placeholder"
  athena_query = "placeholder"
  athena_data_source_name = "placeholder"
  source_data_bucket_id = module.s3-curated-data.curated_s3_bucket_id
  s3_bucket_arn = module.s3-curated-data.curated_s3_bucket_arn
}


# module "emr" {
#   source = "./modules/emr"
# }
# # # # # # # # # # # # # # # #



# # DATA CATALOG & PROCCESS # #
# module "glue-cataloging" {
#   source = "./modules/glue-cataloging"
# }

# module "step-functions" {
#   source = "./modules/step-functions"
# }
# # # # # # # # # # # # # # # #



# # DATA VISUALIZATION # #
# module "quicksight" {
#   source = "./modules/quicksight"
# }



# # MACHINE LEARNING # #
# module "sagemaker" {
#   source = "./modules/sagemaker"
# }
# # # # # # # # # # # # # # # #



# # KMS # #
module "kms" {
  source = "./modules/kms"
}
