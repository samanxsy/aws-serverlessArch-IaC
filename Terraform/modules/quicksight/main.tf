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
  name = "data-lake-analysis"
  analysis_id = "analysis-id"

  definition {
    data_set_identifiers_declarations {
      data_set_arn = aws_quicksight_data_source.datasource.arn
      identifier = "Declare an Identifier"
    }
  }

  permissions {
    principal = "arn:aws:quicksight:us-east-1:${var.ACCOUNT_ID}:namespace/default"
    actions = [
      "quicksight:DescribeAnalysis",
      "quicksight:ListAnalyses",
      "quicksight:UpdateAnalysis",
      "quicksight:DeleteAnalysis"
    ]
  }
}


# QuickSight Data Source
resource "aws_quicksight_data_source" "datasource" {
  name = "data-lake-datasource"
  type = "S3"

  data_source_id = var.data_source_id

  parameters {
    s3 {
      manifest_file_location {
        bucket = "curated-data-bucket"
        key = "manifest-file"
      }
    }
  }

  permission {
    principal = "arn:aws:quicksight:us-east-1:${var.ACCOUNT_ID}:namespace/default"
    actions = [
      "quicksight:DescribeDataSource",
      "quicksight:UpdateDataSource",
      "quicksight:DeleteDataSource"
    ]
  }
}

# # Data Set
resource "aws_quicksight_data_set" "dataset" {
  name = "data-lake-dataset"
  aws_account_id = var.ACCOUNT_ID
  data_set_id = "data-lake-dataset-ID"
  import_mode = "DIRECT_QUERY"

  physical_table_map {
    physical_table_map_id = "PhysicalTableMapID"
  }

  permissions {
    principal = "arn:aws:quicksight:us-east-1:${var.ACCOUNT_ID}:namespace/default"
    actions   = ["quicksight:DescribeDataSet"]
  }
}
