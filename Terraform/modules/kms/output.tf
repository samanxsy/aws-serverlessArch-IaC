# # AWS KMS KEY
# # # # # # # #

# # Output TF File
# # # # # # # # # #


output "kms_key_arn" {
    value = aws_kms_key.kms_key.arn
}
