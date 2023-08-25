# # AWS Seecure Shell File Transfer Protocol
# # # # # # # # # # # # # # # # # # # # # # #

resource "aws_transfer_server" "sftp_server" {
  identity_provider_type = "SERVICE_MANAGED"
  endpoint_type          = "VPC" # Can be `PUBLIC` or set to a Configured VPC for more secure access
}

resource "aws_transfer_user" "sftp_user" {
  server_id           = aws_transfer_server.sftp_server.id
  user_name           = "sftpuser"
  role                = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  home_directory      = "landing/sftp/"
  home_directory_type = "PATH"
}

resource "aws_transfer_ssh_key" "sftp_ssh_key" {
  server_id = aws_transfer_server.sftp_server.id
  user_name = aws_transfer_user.sftp_user.user_name
  body      = var.sftp_public_key
}
