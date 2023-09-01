# # Amazon Glue For data Ingestion
# # # # # # # # # # # # # # # # # #

# # Variables
# # # # # # #


variable "s3_bucket_arn" {
  description = "ARN of the Landing Data S3 bucket"
  type        = string
}

variable "glue_table_name" {
  description = "Name of the glue catalog table"
  type = string
  default = "glue-table"
}

variable "glue_db_name" {
  description = "Name of the glue database to which the table belongs"
  type = string
  default = "glue-database-name"
}

variable "glue_table_type" {
  description = "The type of table"
  type = string
  default = "EXTERNAL_TABLE"
}

variable "external_table" {
  description = "Define whether the table is External or No"
  type = string
  default = "TRUE"
}

variable "storage_location" {
  description = "The S3 path where the table's data is stored"
  type = string
}

variable "storage_input_format" {
  description = "Specify the input format for the data"
  type = string
  default = "org.apache.hadoop.mapred.TextInputFormat"
}

variable "storage_output_format" {
  description = "Specify the output format for the data"
  type = string
  default = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
}

variable "serde_name" {
  description = "Name of the serialization/deserialization for the table's data"
  type = string
  default = "example_name"
}

variable "serialization_library" {
  description = "The library used for serialization/deserialization"
  type = string
  default = "org.openx.data.jsonserde.JsonSerDe"
}

variable "columns" {
  type = list(map(string))
  default = []
}
