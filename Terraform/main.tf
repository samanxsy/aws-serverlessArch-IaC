# Root Terraform Config
#
# Project : Data Lake Infrastructure as Code
#
# License : GNU GENERAL PUBLIC LICENSE
#
# Author : Saman Saybani


# # Modules # #

# # DATA INGESTION
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

  # ENCRYPTION
  encryption_state = "true"
  kms_key_arn = module.kms.kms_key_arn
}


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



# # DATA LAKE # #
module "landing_data_bucket" {
  source      = "./modules/s3_bucket_module"

  # Bucket name and ACL
  bucket_name = "landing-data-bucket"
  acl_state = "private"

  # LifeCycle Configs
  lifecycle_rule_id = "Archiving"
  lifecycle_status = "Enabled"
  transition_days = "100"
  transition_storage_class = "INTELLIGENT_TIERING"

  # Versioning Configs
  versioning_status = "Enabled"
  mfa_status = "Enabled"

  # Encryption
  kms_key_arn = module.kms.kms_key_arn
  encryption_algorithm = "aws:kms"

  # Tags
  bucket_tags = {
    Name = "landing-data"
    Environment = "Dev"
  }
}


module "raw_data_bucket" {
  source      = "./modules/s3_bucket_module"

  # Bucket name and ACL
  bucket_name = "raw-data-bucket"
  acl_state = "private"

  # LifeCycle Configs
  lifecycle_rule_id = "Archiving"
  lifecycle_status = "Enabled"
  transition_days = "100"
  transition_storage_class = "INTELLIGENT_TIERING"

  # Versioning Configs
  versioning_status = "Enabled"
  mfa_status = "Enabled"

  # Encryption
  kms_key_arn = module.kms.kms_key_arn
  encryption_algorithm = "aws:kms"

  # Tags
  bucket_tags = {
    Name = "raw-data"
    Environment = "Dev"
  }
}

module "curated_data_bucket" {
  source      = "./modules/s3_bucket_module"

  # Bucket name and ACL
  bucket_name = "curated-data-bucket"
  acl_state = "private"

  # LifeCycle Configs
  lifecycle_rule_id = "Archiving"
  lifecycle_status = "Enabled"
  transition_days = "100"
  transition_storage_class = "INTELLIGENT_TIERING"

  # Versioning Configs
  versioning_status = "Enabled"
  mfa_status = "Enabled"

  # Encryption
  kms_key_arn = module.kms.kms_key_arn
  encryption_algorithm = "aws:kms"

  # Tags
  bucket_tags = {
    Name = "curated-data"
    Environment = "Dev"
  }
}



# # DATA CATALOG & PROCCESS # #
module "glue_crawler" {
  source = "./modules/glue_crawler"

  # Crawler Name
  crawler_name = "raw-data-crawler"

  # Target S3
  target_s3_bucket_path = "s3://raw-data-bucket"
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
}


# # DATA ANALYTICS # #
module "athena" { # NOT COMPLETE
  source = "./modules/athena"

  # Work Group
  workgroup_name          = "athena-workgroup"
  workgroup_state         = "ENABLED"

  # Athena Named Query
  athena_namedq_query_name = "athena-query-name"
  athena_namedq_db_name           = "athena-db-name"
  athena_query            = "THE SQL QUERY"

  # S3
  s3_bucket_arn           = module.curated_data_bucket.bucket_arn
}


# module "emr" {
#   source = "./modules/emr"
# }
# # # # # # # # # # # # # # # #


# # DATA VISUALIZATION # #
module "quicksight" {
  source         = "./modules/quicksight"

  # Dashboard
  dashboard_name = "data-lake-dashboard"
  dashboard_version = 1
  quicksight_dashboard_id = "dash-id"

  # Dahboard Principals
  dashboard_permission_principal = "arn:aws:quicksight:us-east-1:${var.ACCOUNT_ID}:namespace/default"
  dashboard_permisssion_actions = [
      "quicksight:DescribeDashboard",
      "quicksight:ListDashboardVersions",
      "quicksight:UpdateDashboard",
      "quicksight:DeleteDashboard" 
      # Add more or remove as Needed
  ]

  # Template
  template_name = "data-lake-template"
  template_version = 1
  quicksight_template_id = "TempID"
  template_source_placeholder = "PLACEHOLDER"

  # Analysis
  analysis_name = "data-lake-analysis"
  quicksight_analysis_id = "ID"
  analysis_definition_identifier = "InsuranceData"
  analysis_permission_principal = "arn:aws:quicksight:us-east-1:${var.ACCOUNT_ID}:namespace/default"
  analysis_permission_actions = [
      "quicksight:DescribeAnalysis",
      "quicksight:ListAnalyses",
      "quicksight:UpdateAnalysis",
      "quicksight:DeleteAnalysis"
      # Add more or remove as Needed
  ]

  # Data Source
  data_source_name = "source-name"
  data_source_type = "S3"
  data_source_id = "data-source-ID"

  # Data Source manifest
  manifest_file_s3_bucket = "curated-data-bucket"
  manfiest_file_key = "object-key"
  data_source_permission_principal = "arn:aws:quicksight:us-east-1:${var.ACCOUNT_ID}:namespace/default"
  data_source_permission_actions = [
    "quicksight:DescribeDataSource",
    "quicksight:UpdateDataSource",
    "quicksight:DeleteDataSource"
  ]

  # Data Set
  data_set_name = "data-lake-set"
  ACCOUNT_ID     = var.ACCOUNT_ID
  quicksight_data_set_id = "QSDSID"
  data_set_import_mode = "DIRECT_QUERY"
  data_set_table_map_id = "MappingID"
  data_set_permission_principal = "arn:aws:quicksight:us-east-1:${var.ACCOUNT_ID}:namespace/default"
  data_set_permission_actions = [ "quicksight:DescribeDataSet" ]
}



# # MACHINE LEARNING # #
module "sagemaker" {
  source = "./modules/sagemaker"

  # SageMaker Info
  sagemaker_instance_name = "INSTANCE-NAME"
  sagemaker_instance_type = "ml.t2.medium"
  sagemaker_lifecycle_config_name = "default"

  # Tags
  sagemaker_tags = {
    Name = "NAME"
    Environment = "Prod"
    Project = "Project Name"
    # Add more if needed
  }

  kms_key_arn = module.kms.kms_key_arn
}
# # # # # # # # # # # # # # # #



# # KMS # #
module "kms" {
  source = "./modules/kms"
}


# # Policies # #
module "s3_bucket_policies" {
  source = "./policies/s3_policies"

  # Curated Data Bucket Info
  curated_data_bucket_id = module.curated_data_bucket.bucket_id
  curated_data_bucket_arn = module.curated_data_bucket.bucket_arn

  # Raw Data Bucket info
  raw_data_bucket_id = module.raw_data_bucket.bucket_id
  raw_data_bucket_arn = module.raw_data_bucket.bucket_arn

  # Landing Data Bucket Info
  landing_data_bucket_id = module.landing_data_bucket.bucket_id
  landing_data_bucket_arn = module.landing_data_bucket.bucket_arn
}

module "athena_policies" {
  source = "./policies/athena_policies"
  
  s3_bucket_arn = module.curated_data_bucket.bucket_arn
}
