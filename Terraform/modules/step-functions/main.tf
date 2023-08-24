# AWS Step Functions
# # # # # # # # # # #

resource "aws_sfn_state_machine" "glue_processing_state_machine" {
    name = "glue-processing-state-machine"
    role_arn = aws_iam_role.step_function_role.arn

    definition = jsonencode({
        Comment = "Step function for cataloging and processing",
        StartAt = "RunFirstCrawler",
        States = {
            RunFirstCrawler = {
            Type    = "Task",
            Resource = var.first_glue_crawler_arn,
            Next    = "RunSecondCrawler",
        },
        RunSecondCrawler = {
            Type    = "Task",
            Resource = var.second_glue_crawler_arn,
            End     = true,
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

resource "aws_iam_policy_attachment" "step_function_policy_attachment" {
  name       = "StepFunctionPolicyAttachment"
  roles      = [aws_iam_role.step_function_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSStepFunctions-Role"
}
