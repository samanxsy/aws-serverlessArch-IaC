# # Amazon Glue For data Ingestion
# # # # # # # # # # # # # # # # # #


resource "aws_glue_catalog_table" "glue_table" {
  name          = var.glue_table_name
  database_name = var.glue_db_name

  table_type = var.glue_table_type

  parameters = {
    EXTERNAL = var.external_table
  }

  storage_descriptor {
    location      = var.storage_location
    input_format  = var.storage_input_format
    output_format = var.storage_output_format

    ser_de_info {
      name                  = var.serde_name
      serialization_library = var.serialization_library
    }
  
    dynamic "columns" {
      for_each = var.columns

      content {
        name = columns.value["name"]
        type = columns.value["type"]
      }
    }
  }
}
