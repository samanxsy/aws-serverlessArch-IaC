# # Amazon SageMaker
# # # # # # # # # # #

resource "aws_sagemaker_notebook_instance" "sagemaker_instance" {
    name = var.sagemaker_instance_name
    instance_type = var.sagemaker_instance_type
    role_arn = aws_iam_role.sagemaker_role.arn
    lifecycle_config_name = var.sagemaker_lifecycle_config_name

    kms_key_id = var.kms_key_arn

    tags = var.sagemaker_tags
}


resource "aws_iam_role" "sagemaker_role" {
  name = "sagemaker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      }
    ]
  })
}
