# # Amazon QuickSight
# # # # # # # # # # # 


# # Variables
# # # # # # #


# Dashboard
variable "dashboard_name" {
  description = "Name of the QuickSight Dashboard"
  type = string
  default = "quicksight-dashboard"
}

variable "dashboard_version" {
  description = "Desscribe the version of the dasboard"
  type = number
}

variable "quicksight_dashboard_id" {
  description = "Dashboard ID"
  type = string
}

variable "dashboard_permission_principal" {
  description = "Specify the ARN of the principal (User, Group, or Role) that is granted permissions for the dashboard"
  type = string
}

variable "dashboard_permisssion_actions" {
  description = "List of dashboard actions"
  type = list(string)
  default = [
    "quicksight:DescribeDashboard",
    "quicksight:ListDashboardVersions",
    "quicksight:UpdateDashboard",
    "quicksight:DeleteDashboard"
    # Add more as needed
  ]
}


# Template
variable "template_name" {
  type = string
  default = "quicksight-template"
}

variable "template_version" {
  type = number
}

variable "quicksight_template_id" {
  type = string
}

variable "template_source_placeholder" {
  type = string
  default = "PLACEHOLDER"  
}


# Analysis
variable "analysis_name" {
  type = string
  default = "quicksight-analysis"
}

variable "quicksight_analysis_id" {
  type = string  
}

variable "analysis_definition_identifier" {
  description = "define a user-friendly identifier for the data set"
  type = string
  default = "CustomerData"
}

variable "analysis_permission_principal" {
  description = "Specify the ARN of the principal (User, Group, or Role"
  type = string
}

variable "analysis_permission_actions" {
  description = "list of actions"
  type = list(string)
  default = [ 
    "quicksight:DescribeAnalysis",
    "quicksight:ListAnalyses",
    "quicksight:UpdateAnalysis",
    "quicksight:DeleteAnalysis"
  ]
}


# Data Source
variable "data_source_name" {
  type = string
  default = "data-source"
}

variable "data_source_type" {
  description = "define the type of the data source"
  type = string
  default = "S3"
}

variable "data_source_id" {
  type = string
}

variable "manifest_file_s3_bucket" {
  description = "Specify the location of a manifest file that QuickSight can use to access data"
  type = string
}

variable "manfiest_file_key" {
  description = "the S3 object key to the manifest file within the bucket"
  type = string
}

variable "data_source_permission_principal" {
  type = string
  # 
}

variable "data_source_permission_actions" {
  type = list(string)
  default = [ 
    "quicksight:DescribeDataSource",
    "quicksight:UpdateDataSource",
    "quicksight:DeleteDataSource"
  ]
}

# Data Set
variable "data_set_name" {
  type = string
  default = "data-set"
}

variable "ACCOUNT_ID" {
  type = string
}

variable "quicksight_data_set_id" {
  type = string
}

variable "data_set_import_mode" {
  description = "Determine how data is loaded into QUickSIght"
  type = string
  default = "DIRECT_QUERY"
}

variable "data_set_table_map_id" {
  description = "Define mapping between physical tables and logical tables within the data set"
  type = string
}

variable "data_set_permission_principal" {
  type = string
}

variable "data_set_permission_actions" {
  type = list(string)
  default = [ "quicksight:DescribeDataSet" ]
}
