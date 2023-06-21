variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
  default = "ssh_sg"
}

variable "description" {
  type = string
  default = "sg for web ssh"
}

