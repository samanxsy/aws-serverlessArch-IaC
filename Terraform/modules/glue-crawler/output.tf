# # Glue Crawler
# # # # # # # # #

# # Outputs
# # # # # #

output "raw_data_crawler" {
    value = aws_glue_crawler.raw_data_crawler.name
}

output "glue_db_name" {
    value = aws_glue_catalog_database.catalog_db.name
}
