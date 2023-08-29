# # Amazon Athena
# # # # # # # # #


resource "aws_athena_workgroup" "data_analysis" {
  name  = var.workgroup_name
  state = "ENABLED"
}

resource "aws_athena_named_query" "athena_query" {
  name      = var.query_name
  database  = var.database_name
  query     = var.athena_query
  workgroup = aws_athena_workgroup.data_analysis.name
}


resource "aws_iam_policy" "athena_policy" {
  name        = "AthenaAccessPolicy"
  description = "Policy for Athena to access S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect = "Allow",
        Resource = [
          "${var.s3_bucket_arn}/*"
        ]
      }
    ]
  })
}
