variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "name" {
  type = string
}

variable "public_ip_on_launch" {
  type = bool
  default = false
}
