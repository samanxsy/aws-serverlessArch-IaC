# # Amazon Glue For data Ingestion
# # # # # # # # # # # # # # # # # #

# # Outputs
# # # # # #

output "glue_catalog_table_name" {
  value = aws_glue_catalog_table.glue_table.name
}

output "glue_catalog_table_arn" {
  value = aws_glue_catalog_table.glue_table.arn
}
