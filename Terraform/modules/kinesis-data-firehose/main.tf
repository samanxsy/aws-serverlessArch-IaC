# # Kinesis Firehose
# # # # # # # # # # #

# # ROLE
resource "aws_iam_role" "firehose_role" {
  name = "firehose-role"

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


# # POLICY
resource "aws_iam_policy" "firehose_policy" {
  name = "firehose-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:AbortMultipartUpload",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ],
        Effect   = "Allow",
        Resource = [
          var.landing_s3_bucket_arn,
          "${var.landing_s3_bucket_arn}/*"
        ]
      }
    ]
  })
}


# # ATTACHMENT
resource "aws_iam_role_policy_attachment" "firehose_policy_attachment" {
  policy_arn = aws_iam_policy.firehose_policy.arn
  role       = aws_iam_role.firehose_role.name
}
