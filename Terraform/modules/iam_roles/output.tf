output "sage_maker_role_arn" {
    value = aws_iam_role.sagemaker_role.arn
}

output "glue_crawler_role_arn" {
    value = aws_iam_role.glue_role.arn
}

output "firehose_role_arn" {
    value = aws_iam_role.firehose_role.arn
}

output "step_function_role_arn" {
    value = aws_iam_role.step_function_role.arn 
}