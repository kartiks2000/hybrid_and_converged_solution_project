variable "name" {
  type = string
}

variable "internal" {
  type = bool
  default = false
}

variable "load_balancer_type" {
  type = string
  default = "application"
}

variable "security_groups" {
  type = list(string)
  default = []
}

variable "subnets" {
  type = list(string)
}

variable "environment" {
  type = string
  default = "testing"
}

variable "enable_deletion_protection" {
  type = bool
  default = true
}

