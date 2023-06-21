variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
  default = "webserver_sg"
}

variable "description" {
  type = string
  default = "sg for web servers"
}

