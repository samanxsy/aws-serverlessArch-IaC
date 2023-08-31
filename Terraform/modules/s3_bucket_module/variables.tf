# # Landing Data Bucket
# # # # # # # # # # # #

# # Variables
# # # # # # #

variable "kms_key_arn" {
  type = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type = string
  default = "s3-bucket"
}

variable "acl_state" {
  description = "State of the Acess Control List for the Bucket"
  type = string
  default = "private"
}

variable "versioning_status" {
  description = "Status of the versioning for the S3 bucket"
  type = string
  default = "Enabled"
}

variable "mfa_status" {
  description = "Status of the multi factor authentication for deleting objects in theS3 bucket"
  type = string
  default = "Enabled"
}

variable "lifecycle_rule_id" {
  description = "The ID for the lifecycle rule"
  type = string
  default = "Archiving"
}

variable "lifecycle_status" {
  description = "The Status for the lifecycle, weather 'Enabled' or 'Desabled'"
  type = string
  default = "Enabled"
}

variable "transition_days" {
  description = "Number of days which after the transition happens"
  type = number
  default = 100
}

variable "transition_storage_class" {
  description = "The Storage class the data will be transfered to after the give transition days period"
  type = string
  default = "INTELLIGENT_TIERING"
}

variable "encryption_algorithm" {
  description = "The algorithm for serverside encryption"
  type = string
  default = "aws:kms"
}


variable "bucket_tags" {
  description = "Tags to identify the bucket for several purposes"
  type = map(string)
  default = {
    Name = "s3-bucket"
    Environment = "Dev"
  }
}
