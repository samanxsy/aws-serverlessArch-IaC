# # RAW Data Bucket
# # # # # # # # # #

# # Outputs
# # # # # #

output "raw_s3_bucket_arn" {
  value = aws_s3_bucket.raw_data_bucket.arn
}
