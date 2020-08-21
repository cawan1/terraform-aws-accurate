variable "project" {
  type        = string
  description = "Project Name"
  default     = "teste" #Lower case required #No special character required
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "test"
}