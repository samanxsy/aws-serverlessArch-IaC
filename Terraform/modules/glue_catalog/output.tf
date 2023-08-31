# # Glue Catalog
# # # # # # # # #

# # Outputs
# # # # # #

output "curated_data_table_name" {
  value = aws_glue_catalog_table.curated_data_table.name
}

output "curated_data_table_arn" {
  value = aws_glue_catalog_table.curated_data_table.arn
}
