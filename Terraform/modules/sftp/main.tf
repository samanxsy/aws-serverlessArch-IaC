# # AWS Seecure Shell File Transfer Protocol
# # # # # # # # # # # # # # # # # # # # # # #

resource "aws_transfer_server" "sftp_server" {
  identity_provider_type = var.id_provider_type
  endpoint_type          = var.endpoint
}

resource "aws_transfer_user" "sftp_user" {
  server_id           = aws_transfer_server.sftp_server.id
  user_name           = var.transfer_user_name
  role                = var.transfer_user_role
  home_directory      = var.transfer_user_home_directory
  home_directory_type = var.transfer_user_home_directory_type
}

resource "aws_transfer_ssh_key" "sftp_ssh_key" {
  server_id = aws_transfer_server.sftp_server.id
  user_name = aws_transfer_user.sftp_user.user_name
  body      = var.sftp_public_key
}
