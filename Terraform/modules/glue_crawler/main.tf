# # Amazon Glue Crawler
# # # # # # # # # # # #


resource "aws_glue_crawler" "raw_data_crawler" {
  name          = "raw-data-crawler"
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.catalog_db.name

  s3_target {
    path = "s3://raw-data-bucket"
  }
}


# # IAM ROLE
resource "aws_iam_role" "glue_role" {
  name = "glue-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}


# # Cataloge DB
resource "aws_glue_catalog_database" "catalog_db" {
  name = "data-catalog"
}
