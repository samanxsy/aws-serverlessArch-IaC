# # Amazon Athena
# # # # # # # # #

# # Variable
# # # # # # #


variable "workgroup_name" {
  description = "Name of the athena work group"
  type = string
  default = "athena-wg"
}

variable "workgroup_state" {
  description = "Initial state of the athena work group"
  type = string
  default = "ENABLED"
}

variable "athena_namedq_query_name" {
  description = "Name of the athena query"
  type = string
  default = "athena-query"
}

variable "athena_namedq_db_name" {
  description = "This specifies the Athena database where the query will run"
  type = string
}

variable "athena_query" {
  description = "This sets the actual SQL query that the named query represents"
  type = string
}

# S3
variable "s3_bucket_arn" {
  type = string
}
