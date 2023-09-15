# Module
#
# SageMaker | Machine Learning


module "sagemaker" {
  source = "./modules/sagemaker"

  # SageMaker Info
  sagemaker_instance_name = "INSTANCE-NAME"
  sagemaker_instance_type = "ml.t2.medium"
  sagemaker_lifecycle_config_name = "default"
  sage_maker_role = module.iam_roles.sage_maker_role_arn


  # Tags
  sagemaker_tags = {
    Name = "NAME"
    Environment = "Prod"
    Project = "Project Name"
    # Add more if needed
  }

  kms_key_arn = module.kms.kms_key_arn
}
