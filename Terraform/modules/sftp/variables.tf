# # AWS Seecure Shell File Transfer Protocol
# # # # # # # # # # # # # # # # # # # # # # #

# # Variables
# # # # # # #

variable "id_provider_type" {
  description = "Type of the identity provider"
  type = string
  default = "SERVICE_MANAGED"
}

variable "endpoint" {
  description = "Endpoint type; Can be Public, or set to a configured VPC for a granular access"
  type = string
  default = "VPC"
}

variable "transfer_user_name" {
  description = "The username for the aws transfer user reource"
  type = string
  default = "sftpuser"
}

variable "transfer_user_role" {
  description = "The IAM Role for the transfer user resource"
  type = string
}

variable "transfer_user_home_directory" {
  description = "Home directory path"
  type = string
  default = "usr/sftp"
}

variable "transfer_user_home_directory_type" {
  description = "Home directory type"
  type = string
  default = "PATH"
}

variable "sftp_public_key" {
  description = "Public SSH key for the SFTP user"
  type        = string
}


variable "s3_bucket_arn" {
  description = "ARN of the Landing Data S3 bucket"
  type        = string
}
