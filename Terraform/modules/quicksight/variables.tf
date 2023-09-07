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
  default = "templateID"
}

variable "template_source_placeholder" {
  type = string
  default = "PLACEHOLDER"  
}


variable "ACCOUNT_ID" {
  type = string
}

variable "data_source_id" {
  type = string
}
