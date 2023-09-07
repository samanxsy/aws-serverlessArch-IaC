# # # Terraform configs # # #
# # # # # # # # # # # # # # #

terraform {
  cloud {
    organization = "vx_data_lake"
    workspaces {
      name = "data-lake-iac"
    }
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
