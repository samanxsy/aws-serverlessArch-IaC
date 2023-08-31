# # AWS Step Functions
# # # # # # # # # # # #

# # Outputs
# # # # # #

output "state_machine_arn" {
    value = aws_sfn_state_machine.glue_processing_state_machine.arn
}
