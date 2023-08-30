# # # Terraform configs # # #
# # # # # # # # # # # # # # #

terraform {
  backend "remote" {
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
