variable "project" {
  type        = string
  description = "Project Name"
  default     = "pantheon" #Lower case required #No special character required
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "mattermost_webhook" {
  type = string
  description = "Mattermost webhook for lambda notification"
  default = "https://chat.acclabs.com.br/hooks/e4gk5ezpnbfupqpprtt8bi9uzh"
}

variable "mattermost_channel" {
  type = string
  description = "Mattermost channel for lambda notification"
  default = "panthen-status"
}