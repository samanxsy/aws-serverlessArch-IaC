# ARN
# Landing Data Bucket ARN
output "landing_data_bucket_arn" {
    value = module.landing_data_bucket.bucket_arn
}

# Raw Data Bucket ARN
output "raw_data_bucket_arn" {
    value = module.raw_data_bucket.bucket_arn
}

# Curated Data Bucket ARN
output "curated_data_bucket_arn" {
    value = module.curated_data_bucket.bucket_arn
}


# ID
# Landing Data Bucket ID
output "landing_data_bucket_id" {
  value = module.landing_data_bucket.bucket_id
}

# Raw Data Bucket ID
output "raw_data_bucket_id" {
  value = module.raw_data_bucket.bucket_id
}

# Curated Data Bucket ID
output "curated_data_bucket_id" {
  value = module.curated_data_bucket.bucket_id
}
