variable "project" {
  type = string
  description = "Project Name"
}

variable "environment" {
  type = string
  description = "environment"
}

variable "schedule_start" {
  description = "Define schedule Start to apply on RDS resources, accepted value are true or false."
  type        = bool
  default     = false
}

variable "cloudwatch_schedule_start_expression" {
  description = "Define the aws cloudwatch event rule schedule expression GMT"
  type        = string 
  default     = "cron(00 05 ? * MON-FRI *)"  ##GMT TIME
}


variable "schedule_stop" {
  description = "Define schedule Stop to apply on RDS resources, accepted value are true or false."
  type        = bool
  default     = true
}


variable "cloudwatch_schedule_stop_expression" {
  description = "Define the aws cloudwatch event rule schedule expression GMT"
  type        = string
  default     = "cron(00 23 ? * MON-FRI *)"  ## GMT TIME
}

variable "mattermost_webhook" {
  type = string
  description = "Mattermost webhook for lambda notification"
}

variable "mattermost_channel" {
  type = string
  description = "Mattermost channel for lambda notification"
}



