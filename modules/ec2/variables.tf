variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "name" {
  type = string
}

variable "availability_zone" {
  type = string
  nullable = false
  default = ""
}

variable "key_name" {
  type = string
  nullable = false
  default = ""
}

variable "launch_template" {
  type = string
  nullable = false
  default = ""
}

variable "security_group_ids" {
  type = list(string)
  nullable = false
  default = []
}

variable "subnet_id" {
  type = string
  nullable = false
  default = ""
}


