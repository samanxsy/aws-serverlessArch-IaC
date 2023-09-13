# # AWS Step Functions
# # # # # # # # # # # #

resource "aws_sfn_state_machine" "glue_processing_state_machine" {
  name     = var.state_machine_name
  role_arn = aws_iam_role.step_function_role.arn

  definition = jsonencode({
    Comment = var.state_machine_definition_comment,
    StartAt = var.initial_point_state,
    States = {
      RunFirstCrawler = {
        Type     = "Task",
        Resource = var.first_glue_crawler_arn,
        Next     = "RunSecondCrawler",
      },
      RunSecondCrawler = {
        Type     = "Task",
        Resource = var.second_glue_crawler_arn,
        End      = true,
      },
    },
  })
}


resource "aws_iam_role" "step_function_role" {
  name = "StepFunctionExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "states.amazonaws.com",
        },
      },
    ],
  })
}
