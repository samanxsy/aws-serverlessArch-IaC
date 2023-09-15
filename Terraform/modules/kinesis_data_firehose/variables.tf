# # Amazon Kinesis Data Stream
# # # # # # # # # # # # # # # #

# # Variables
# # # # # # #

# NAME
variable "firehose_name" {
  description = "Name of the kinesis firehose delivery stream"
  type = string
  default = "KINESIS-FIREHOSE-DS"
}

# DESTINATION
variable "delivery_destination" {
  description = "The destination of the kinesis firehose delivery stream"
  type = string
  default = "extended_s3"
}

# Bucket ARN
variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket that data is being ingested to"
  type = string
}

# BUFFER SIZE
variable "buffer_size" {
  description = "The size of the buffer that Kinesis Firehose uses before delivering the data to the destination bucket"
  type = number
  default = 64
}

# PARTITIONING
variable "dynamic_partitioning_enabling" {
  description = "Enable or Disabling the dynamic partitioning for the bucket"
  type = string
  default = "true"
}

# OBJECT PREFIX
variable "objects_prefix" {
  description = "Add a prefix to objects' key names when stored in the Bucket"
  type = string
  default = "data/info/id"
}

# ERRORs PREFIX
variable "errors_prefix" {
  description = "Define a prefix to be added to the objects' key names for error records that occure during delivery"
  type = string
  default = "errors/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/!{firehose:error-output-type}/"
}

# PROCESSORS
variable "processing_state" {
  description = "Enable or Disable the prossesing configuration block"
  type = string
  default = "true"
}

variable "processors" {
  type = list(object({
    type       = string
    parameters = list(object({
      param_name  = string
      param_value = string
    }))
  }))
  default = []
}

# ENCRYPTION
variable "encryption_state" {
  description = "Enable or Desable the Server Side Encryption"
  type = string
  default = "true"
}

# KMS
variable "kms_key_arn" {
  description = "KMS Key ARN"
  type = string
}


variable "kinesis_role" {
  type = string 
}
