# # Curated Data Bucket
# # # # # # # # # # # #

# # Outputs
# # # # # #

output "curated_s3_bucket_arn" {
  value = aws_s3_bucket.curated_data_bucket.arn
}

output "curated_s3_bucket_id" {
  value = aws_s3_bucket.curated_data_bucket.id
}
