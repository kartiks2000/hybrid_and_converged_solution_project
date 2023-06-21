variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
  default = "icmp_ping_sg"
}

variable "description" {
  type = string
  default = "sg for ping servers"
}

