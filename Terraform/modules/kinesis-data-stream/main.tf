# Amazon Kinesis Data Stream for IoT Sensors Data Ingestion
resource "aws_kinesis_stream" "iot_sensors_stream" {
  name             = "iot-sensors-stream"
  shard_count      = 1  # Adjust as needed based on your anticipated data rate

  encryption_type = "KMS"
  kms_key_id = var.kms_key_arn

  retention_period = 48  # Retain data for 48 hours, adjust as needed

  tags = {
    Name = "IoT Sensors Stream"
  }
}
