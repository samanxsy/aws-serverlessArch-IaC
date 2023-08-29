# # Amazon SageMaker
# # # # # # # # # # #

# # Outputs
# # # # # #

output "sagemaker_instance_arn" {
  value = aws_sagemaker_notebook_instance.sagemaker_instance.arn
}
