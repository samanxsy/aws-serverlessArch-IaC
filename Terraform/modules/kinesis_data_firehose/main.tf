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

      dynamic "processors" {
        for_each = var.processors

        content {
          type = processors.value["type"]

          dynamic "parameters" {
            for_each = processors.value["parameters"]

            content {
              parameter_name = parameters.value["param_name"]
              parameter_value = parameters.value["param_value"]
            }
          }
        }      
      }
    }
  }

  server_side_encryption {
    enabled = var.encryption_state
  }
}

# # ROLE
resource "aws_iam_role" "firehose_role" {
  name               = "firehose_test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "firehose.amazonaws.com"
        }
      }
    ]
  })
}
