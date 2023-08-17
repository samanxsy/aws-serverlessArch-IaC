# # Amazon Glue Catalog
# # # # # # # # # # # #

resource "aws_glue_catalog_table" "curated_data_table" {
  name = "curated_data"
  database_name = var.glue_db_name
  table_type = "EXTERNAL_TABLE"

  parameters = {
    "classification" = "parquet"
  }
  storage_descriptor {
    location = "s3://curated-data-bucket/"
    input_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
    compressed = false
    columns {
      name = "column1"
      type = "string"
    }
    # Define more columns as needed
  }
}
