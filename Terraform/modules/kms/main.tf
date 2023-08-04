# # AWS KMS KEY
# # # # # # # #

resource "aws_kms_key" "kms_key" {
    description = "KMS KEY"
    enable_key_rotation = true
    # deletion_window_in_days = 20
}
