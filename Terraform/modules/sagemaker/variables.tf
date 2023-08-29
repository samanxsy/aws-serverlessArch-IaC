# # Amazon SageMaker
# # # # # # # # # # #

# # Variables
# # # # # # #

variable "sagemaker_instance_name" {
    type = string
    default = "sage-maker-instance"
}


variable "sagemaker_instance_type" {
    type = string
    default = "ml.t2.medium"
}

variable "sagemaker_lifecycle_config_name" {
    type = string
    default = "default"
}

variable "sagemaker_tags" {
    type = map(string)
    default = {}
}

variable "kms_key_arn" {
    type = string
}
