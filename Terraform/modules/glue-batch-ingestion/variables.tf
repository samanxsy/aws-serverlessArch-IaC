# # Amazon Glue For data Ingestion
# # # # # # # # # # # # # # # # # #

# # Variables
# # # # # # #


variable "landing_s3_bucket_arn" {
  description = "ARN of the Landing Data S3 bucket"
  type        = string
}

variable "glue_db_name" {
  type = string
}
