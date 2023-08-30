# Landing Data Bucket Policies
#
# Bucket Policy Glue, and Glue Cataloging

resource "aws_s3_bucket_policy" "glue_bucket_policy" {
  bucket = var.landing_data_bucket_id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject"],
        Effect   = "Allow",
        Resource = "${var.landing_data_bucket_arn}/*",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "glue_catalog_bucket_policy" {
  bucket = var.landing_data_bucket_id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:PutObject"], # Add "s3:PutObject" action here
        Effect   = "Allow",
        Resource = "${var.landing_data_bucket_arn}/*",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}
