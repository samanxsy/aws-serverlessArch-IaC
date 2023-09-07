# # Amazon QuickSight
# # # # # # # # # # #


# # QuickSight Dashboard
resource "aws_quicksight_dashboard" "dashboard" {
  name = var.dashboard_name
  version_description = 1
  dashboard_id = var.quicksight_dashboard_id

  source_entity {
    source_template {
      arn = aws_quicksight_template.template.arn
      data_set_references {
        data_set_placeholder = aws_quicksight_data_set.dataset.name
        data_set_arn         = aws_quicksight_data_set.dataset.arn
      }
    }
  }

  permissions {
    principal = var.dashboard_permission_principal
    actions = var.dashboard_permisssion_actions
  }
}


# # QuickSight Template
resource "aws_quicksight_template" "template" {
  name = var.template_name
  version_description = var.template_version
  template_id = var.quicksight_template_id

  source_entity {
    source_analysis {
      arn = aws_quicksight_analysis.analysis.arn
      data_set_references {
        data_set_placeholder = var.template_source_placeholder
        data_set_arn = aws_quicksight_data_set.dataset.arn
      }
    }
  }
}


# # QuickSight Analysis
resource "aws_quicksight_analysis" "analysis" {
  name = var.analysis_name
  analysis_id = var.quicksight_analysis_id

  definition {
    data_set_identifiers_declarations {
      data_set_arn = aws_quicksight_data_source.datasource.arn
      identifier = var.analysis_definition_identifier
    }
  }

  permissions {
    principal = var.analysis_permission_principal
    actions = var.dashboard_permisssion_actions
  }
}


# QuickSight Data Source
resource "aws_quicksight_data_source" "datasource" {
  name = var.data_source_name
  type = var.data_source_type

  data_source_id = var.data_source_id

  parameters {
    s3 {
      manifest_file_location {
        bucket = var.manifest_file_s3_bucket
        key = var.manfiest_file_key
      }
    }
  }

  permission {
    principal = var.data_source_permission_principal
    actions = var.data_source_permission_actions
  }
}

# # Data Set
resource "aws_quicksight_data_set" "dataset" {
  name = var.data_set_name
  aws_account_id = var.ACCOUNT_ID
  data_set_id = var.quicksight_data_set_id
  import_mode = var.data_set_import_mode

  physical_table_map {
    physical_table_map_id = var.data_set_table_map_id
  }

  permissions {
    principal = var.data_set_permission_principal
    actions   = var.data_set_permission_actions
  }
}
