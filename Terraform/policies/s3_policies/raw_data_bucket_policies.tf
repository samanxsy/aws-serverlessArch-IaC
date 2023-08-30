# Raw Data Bucket Policies
#
# Bucket Policy Glue, and Glue Jobs


# Bucket Policy for Glue
resource "aws_s3_bucket_policy" "glue_bucket_policy" {
  bucket = var.raw_data_bucket_id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject"],
        Effect   = "Allow",
        Resource = "${var.raw_data_bucket_arn}/*",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}


# Bucket Policy for Glue Cataloging (Consumed by Curated Data Glue Job)
resource "aws_s3_bucket_policy" "glue_catalog_bucket_policy" {
  bucket = var.raw_data_bucket_id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:PutObject"],
        Effect   = "Allow",
        Resource = "${var.raw_data_bucket_arn}/*",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}
