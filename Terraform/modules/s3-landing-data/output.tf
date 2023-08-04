# # Landing Data Bucket
# # # # # # # # # # # #

# # Outputs TF File
# # # # # # # # # #

output "landing_s3_bucket_arn" {
    value = aws_s3_bucket.landing_data_bucket.arn
}
