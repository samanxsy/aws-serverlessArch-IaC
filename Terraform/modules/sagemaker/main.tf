# # Amazon SageMaker
# # # # # # # # # # #

resource "aws_sagemaker_notebook_instance" "sagemaker_instance" {
    name = var.sagemaker_instance_name
    instance_type = var.sagemaker_instance_type
    role_arn = var.sage_maker_role
    lifecycle_config_name = var.sagemaker_lifecycle_config_name
      direct_internet_access = "Disabled"

    kms_key_id = var.kms_key_arn

    tags = var.sagemaker_tags
}
