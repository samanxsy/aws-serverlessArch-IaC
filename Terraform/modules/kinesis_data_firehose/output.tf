# # Kinesis Firehose
# # # # # # # # # # #

# # Outputs
# # # # # #

output "kinesis_firehose_delivery_stream_arn" {
    value = aws_kinesis_firehose_delivery_stream.IoT_ingestion.arn
}
