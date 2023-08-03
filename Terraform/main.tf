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
module "kinesis-data-stream" {
  source = "./modules/kinesis-data-stream"
}

module "glue-batch-ingestion" {
  source = "./modules/glue-batch-ingestion"
}

module "sftp" {
  source = "./modules/sftp"
}
# # # # # # # # # # # # # # # #



# # DATA LAKE # #
module "s3-landing-data" {
  source = "./modules/s3-landing-data"
}

module "s3-raw-data" {
  source = "./modules/s3-raw-data"
}

module "s3-curated-data" {
  source = "./modules/s3-curated-data"
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
  source_data_bucket_id = "placeholder"
  s3_bucket_arn = "placeholder"
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
