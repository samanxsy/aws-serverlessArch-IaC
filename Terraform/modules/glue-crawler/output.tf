# # Glue Crawler
# # # # # # # # #

# # Outputs
# # # # # #

output "raw_data_crawler_arn" {
    value = aws_glue_crawler.raw_data_crawler.arn
}

output "glue_db_name" {
    value = aws_glue_catalog_database.catalog_db.name
}
