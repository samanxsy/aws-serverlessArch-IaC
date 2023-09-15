# Modules
#
# DATA INGESTION


# IOT Devices
module "kinesis_data_firehose" {
  source                = "./modules/kinesis_data_firehose"

  # Name and Destination
  firehose_name = "iot-sensors-data-ingestion"
  delivery_destination = "extended_s3"

  # BUCKET
  s3_bucket_arn = module.landing_data_bucket.bucket_arn
  buffer_size = 64

  # DYNAMIC PARTITION
  dynamic_partitioning_enabling = "true"

  # OBJECT PREFIXES
  objects_prefix = "data/info/id" # PLACEHOLDER
  errors_prefix = "errors/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/!{firehose:error-output-type}/" # EXAMPLE

  # PROCESSING
  processing_state = "true"

  # PROCESSORS
  processors = [
    {
      type = "RecordDeAggregation"
      parameters = [
        { param_name = "SubRecordType", param_value = "JSON" }
      ]
    },
    {
      type = "MetadataExtraction"
      parameters = [
        { param_name = "JsonParsingEngine", param_value = "JQ-1.6"}
      ]
    } # ADD MORE PROCESSORS IF NEEDED
  ]

  # Role
  kinesis_role = module.iam_roles.firehose_role_arn

  # ENCRYPTION
  encryption_state = "true"
  kms_key_arn = module.kms.kms_key_arn
}


# Batch Ingestion from Existing Databases
module "glue_batch_ingestion" {
  source                = "./modules/glue_batch_ingestion"
  s3_bucket_arn = module.landing_data_bucket.bucket_arn
  glue_db_name          = module.glue_crawler.glue_db_name
  glue_table_name = "glue-table"

  glue_table_type = "EXTERNAL_TABLE"
  external_table = "TRUE"

  storage_location = "s3://${module.landing_data_bucket.bucket_arn}/landing/glue/"
  storage_input_format = "org.apache.hadoop.mapred.TextInputFormat"
  storage_output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

  serde_name = "example_name"
  serialization_library = "org.openx.data.jsonserde.JsonSerDe"
  columns = [
    { name = "column1", type = "string" },
    { name = "column2", type = "int" },
    { name = "column3", type = "string" }
    # ...
    # ADD MORE IF NEEDED
  ]
}


# 3rd party data
module "sftp" {
  source                = "./modules/sftp"

  # Transfer Server
  id_provider_type = "SERVICE_MANAGED"
  endpoint = "VPC"

  # Tranfer User
  transfer_user_name = "SFTP-USER"
  transfer_user_home_directory = "usr/sftp"
  transfer_user_home_directory_type = "PATH"
  transfer_user_role = "arn:aws:iam::aws:policy/AmazonS3FullAccess"


  # Transfer Key
  sftp_public_key       = var.TRANSFER_PUBLIC_KEY

  # S3 Bucket
  s3_bucket_arn = module.landing_data_bucket.bucket_arn
}
