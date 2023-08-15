# # Amazon Glue For data Ingestion
# # # # # # # # # # # # # # # # # #

# # Outputs TF File
# # # # # # # # # #

output "glue_catalog_table_name" {
  value = aws_glue_catalog_table.example_table.name
}

output "glue_catalog_table_arn" {
  value = aws_glue_catalog_table.example_table.arn
}
