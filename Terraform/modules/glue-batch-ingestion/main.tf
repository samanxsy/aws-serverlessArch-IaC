# # Amazon Glue For data Ingestion
# # # # # # # # # # # # # # # # # #


resource "aws_glue_catalog_database" "glue_db" {
  name = "glue-db"
}

resource "aws_glue_catalog_table" "glue_table" {
  name     = "glue-table"
  database_name = aws_glue_catalog_database.glue_db.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL = "TRUE"
  }

  storage_descriptor {
    location      = "s3://${var.landing_s3_bucket_arn}/landing/glue/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "example_table"
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }

    columns {
      name = "column1"
      type = "string"
    }

    columns {
      name = "column2"
      type = "string"
    }

    columns {
      name = "column3"
      type = "string"
    }

    columns {
      name = "column4"
      type = "string"
    }
  }
}
