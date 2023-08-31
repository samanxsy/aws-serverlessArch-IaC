# # Kinesis Firehose
# # # # # # # # # # #


resource "aws_kinesis_firehose_delivery_stream" "IoT_ingestion" {
  name        = var.firehose_name
  destination = var.delivery_destination

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = var.s3_bucket_arn

    buffering_size = var.buffer_size

    dynamic_partitioning_configuration {
      enabled = var.dynamic_partitioning_enabling
    }

    prefix              = var.objects_prefix
    error_output_prefix = var.errors_prefix

    processing_configuration {
      enabled = var.processing_state

      processors {
        type = var.processor_type_1
        parameters {
          parameter_name  = var.processor_type_1_param_name
          parameter_value = var.processor_type_1_param_value
        }
      }

      processors {
        type = var.processor_type_2
        parameters {
          parameter_name  = var.processor_type_2_param_name
          parameter_value = var.processor_type_2_param_value
        }
      }
    }
  }
  server_side_encryption {
    enabled = var.encryption_state
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
