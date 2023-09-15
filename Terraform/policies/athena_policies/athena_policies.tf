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
