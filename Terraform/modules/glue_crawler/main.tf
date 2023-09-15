# # Amazon Glue Crawler
# # # # # # # # # # # #


resource "aws_glue_crawler" "raw_data_crawler" {
  name          = var.crawler_name
  role          = var.glue_crawler_role
  database_name = aws_glue_catalog_database.catalog_db.name

  s3_target {
    path = var.target_s3_bucket_path
  }
}

# # Cataloge DB
resource "aws_glue_catalog_database" "catalog_db" {
  name = "data-catalog"
}
