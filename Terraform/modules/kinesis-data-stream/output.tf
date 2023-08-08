# Output variables from the Kinesis Data Stream module
output "iot_sensors_stream_name" {
  value = aws_kinesis_stream.iot_sensors_stream.name
}

output "iot_sensors_stream_arn" {
  value = aws_kinesis_stream.iot_sensors_stream.arn
}
