# # AWS Seecure Shell File Transfer Protocol
# # # # # # # # # # # # # # # # # # # # # # #

# # Outputs
# # # # # #

output "sftp_server_id" {
  value = aws_transfer_server.sftp_server.id
}

output "sftp_user_name" {
  value = aws_transfer_user.sftp_user.user_name
}
