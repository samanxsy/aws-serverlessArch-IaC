# # AWS Seecure Shell File Transfer Protocol
# # # # # # # # # # # # # # # # # # # # # # #

# # Variables
# # # # # # #

variable "landing_s3_bucket_arn" {
  description = "ARN of the Landing Data S3 bucket"
  type        = string
}

variable "sftp_public_key" {
  description = "Public SSH key for the SFTP user"
  type        = string
}
