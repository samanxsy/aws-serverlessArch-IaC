# # Glue Catalog
# # # # # # # # #

# # Outputs
# # # # # #

output "raw_data_crawler" {
    value = aws_glue_crawler.raw_data_crawler.name
}
