# # Amazon Glue Crawler
# # # # # # # # # # # #

# # Variables
# # # # # # #

variable "crawler_name" {
    description = "Name of the aws glue crawler"
    type = string
    default = "crawler-itself"
}

variable "target_s3_bucket_path" {
    description = "The path to the target s3 bucket"
    type = string
}


variable "glue_crawler_role" {
    type = string
}