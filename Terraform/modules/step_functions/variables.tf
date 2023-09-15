# AWS Step Functions
# # # # # # # # # # #

# Variables
# # # # # #

variable "state_machine_name" {
  description = "Name of the step function's state machine"
  type = string
  default = "the-default-state-machine"
}

variable "state_machine_definition_comment" {
  description = "Add an explanatory comment for the statemachine definition"
  type = string
  default = "Step Function's State"
}

variable "initial_point_state" {
  description = "Specify the initial state of the state machine"
  type = string
}


variable "first_glue_crawler_arn" {
  type = string
}

variable "second_glue_crawler_arn" {
  type = string
}


variable "step_function_role" {
  type = string
}