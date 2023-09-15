# Modules
#
# Data Catalog and Processing


module "glue_crawler" {
  source = "./modules/glue_crawler"

  # Crawler Name
  crawler_name = "raw-data-crawler"

  # Target S3
  target_s3_bucket_path = "s3://raw-data-bucket"

  # Role
  glue_crawler_role = module.iam_roles.glue_crawler_role_arn
}

module "glue_catalog" {
  source       = "./modules/glue_catalog"

  # Glue Catalog
  glue_catalog_table_name = "raw-data"
  glue_db_name = module.glue_crawler.glue_db_name

  # Parameter
  classification_parameter = "parquet"

  # Storage
  storage_location = "s3://curated-data-bucket/"
  storage_input_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
  storage_output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
  compression_state = false

  # Columns
  columns = [
    { name = "column1", type = "string" },
    { name = "column2", type = "int" },
    { name = "column3", type = "string" }
    # ...
    # ADD MORE IF NEEDED
  ]
}

module "step_functions" { # NOT COMPLETE YET
  source                  = "./modules/step_functions"

  # Info
  state_machine_name = "data-processor-machine"

  # State Machine Definition
  state_machine_definition_comment = "The state machine for the data processing cycle"
  initial_point_state = "RunFirstCrawler" 

  # Crawler Tasks
  first_glue_crawler_arn  = module.glue_crawler.raw_data_crawler_arn
  second_glue_crawler_arn = module.glue_catalog.curated_data_table_arn

  # Role
  step_function_role = module.iam_roles.step_function_role_arn
}
