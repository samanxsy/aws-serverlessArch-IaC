# # Glue Catalog
# # # # # # # # #

# # Variables
# # # # # # #

variable "glue_db_name" {
  type = string
}

variable "glue_catalog_table_name" {
  type = string
  default = "catalog-table"
}

variable "glue_catalog_table_type" {
  type = string
  default = "EXTERNAL_TABLE"
}

variable "classification_parameter" {
  description = "The classification format"
  type = string

  # Example :  "parquet"
}

variable "storage_location" {
  description = "The path (Address) to the storage location"
  type = string

  # Example : "s3://curated-data-bucket/"
}

variable "storage_input_format" {
  description = "The format of the input"
  type = string

  # Example : "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
}

variable "storage_output_format" {
  description = "The format of the output"
  type = string

  # Example: "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
}

variable "compression_state" {
  description = "Compressing the data (true) or not (false)"
  type = bool
  default = false
}

variable "columns" {
  description = "colmuns defined in the storage"
  type = list(map(string))
  default = []
}
