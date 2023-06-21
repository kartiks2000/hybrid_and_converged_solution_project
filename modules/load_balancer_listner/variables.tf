variable "load_balancer_arn" {
  type = string
}

variable "port" {
  type = string
  default = "80"
}

variable "protocol" {
  type = string
  default = "HTTP"
}

variable "target_group_arn" {
  type = string
}

variable "action_type" {
  type = string
  default = "forward"
}

