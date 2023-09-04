# # Amazon Glue Catalog
# # # # # # # # # # # #

resource "aws_glue_catalog_table" "curated_data_table" {
  name          = var.glue_catalog_table_name
  database_name = var.glue_db_name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification" = var.classification_parameter
  }

  storage_descriptor {
    location      = var.storage_location
    input_format  = var.storage_input_format
    output_format = var.storage_output_format
    compressed    = var.compression_state

    dynamic "columns" {
      for_each = var.columns

      content {
        name = columns.value["name"]
        type = columns.value["type"]
      }
    }
  }
}
