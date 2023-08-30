# Curated Data Bucket Policies
#
# Bucket Policy for Athena, EMR, and Glue

resource "aws_s3_bucket_policy" "athena_emr_glue_bucket_policy" {
  bucket = var.curated_data_bucket_id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject"],
        Effect   = "Allow",
        Resource = "${var.curated_data_bucket_arn}/*",
        Principal = {
          Service = "athena.amazonaws.com"
        }
      },
      {
        Action   = ["s3:GetObject"],
        Effect   = "Allow",
        Resource = "${var.curated_data_bucket_arn}/*",
        Principal = {
          Service = "elasticmapreduce.amazonaws.com"
        }
      },
      {
        Action   = ["s3:PutObject"],
        Effect   = "Allow",
        Resource = "${var.curated_data_bucket_arn}/*",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}
