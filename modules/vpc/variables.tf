variable "project" {
  type = string
  description = "Project Name"
}
variable "environment" {
  type = string
  description = "environment"
}


######   NETWORK  #########
variable "cidr" {
  type = string
  default = "20.10.0.0/16"
}

variable "azs" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# variable "private_subnets" {
#   type = list(string)
#   default = ["20.10.1.0/24", "20.10.2.0/24"]
# }

variable "public_subnets" {
  type = list(string)
  default = ["20.10.11.0/24", "20.10.12.0/24"]
}

variable "database_subnets" {
  type = list(string)
  default = ["20.10.21.0/24", "20.10.22.0/24"]
}

