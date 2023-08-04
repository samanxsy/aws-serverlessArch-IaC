# # Amazon Athena
# # # # # # # # #

# # Variables TF File
# # # # # # # # # # #


variable "workgroup_name" {
    type = string
}

variable "database_name" {
    type = string
}

variable "query_name" {
    type = string
}

variable "athena_query" {
    type = string
}

variable "athena_data_source_name" {
    type = string
}

variable "source_data_bucket_id" {
    type = string
}

variable "s3_bucket_arn" {
    type = string
}
