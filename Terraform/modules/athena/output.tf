# # Amazon Athena
# # # # # # # # #

# # Outputs
# # # # # #

output "workgroup_arn" {
  value = aws_athena_workgroup.data_analysis.arn
}

output "query_id" {
  value = aws_athena_named_query.athena_query.id
}
