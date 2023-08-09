# # Kinesis Firehose
# # # # # # # # # # #


resource "aws_kinesis_firehose_delivery_stream" "IoT_ingestion" {
  name = "iot-sensors-data-ingestion"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn = aws_iam_role.firehose_role.arn
    bucket_arn = var.landing_s3_bucket_arn

    buffering_size = 64
  
    dynamic_partitioning_configuration {
      enabled = "true"
    }

    prefix = "data/info/id" # PLACEHOLDER
    error_output_prefix = "errors/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/!{firehose:error-output-type}/"

    processing_configuration {
      enabled = "true"

      processors {
        type = "RecordDeAggregation"
        parameters {
          parameter_name = "SubRecordType"
          parameter_value = "JSON"
        }
      }

      processors {
        type = "MetadataExtraction"
        parameters {
          parameter_name  = "JsonParsingEngine"
          parameter_value = "JQ-1.6"
      }
      parameters {
          parameter_name  = "MetadataExtractionQuery"
          parameter_value = "{customer_id:.customer_id}" # # PLACEHOLDER
        }
      }
    }
  }
  server_side_encryption {
    enabled = "true"
  }
}


# # POLICY
data "aws_iam_policy_document" "firehose_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# # ROLE
resource "aws_iam_role" "firehose_role" {
  name               = "firehose_test_role"
  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
}
