# Modules
#
# Data Visualization and Analytics


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
