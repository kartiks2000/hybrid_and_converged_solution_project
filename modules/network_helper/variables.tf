variable "cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type = string
  default = "default"
}

variable "name" {
  type = string
  default = "my-vpc"
}


variable "public_subnets" {
  type = list(
    object({
        name = string
        cidr_block = string
        availability_zone = string
    })
  )
  default = []
}

variable "private_subnets" {
  type = list(
    object({
        name = string
        cidr_block = string
        availability_zone = string
    })
  )
  default = []
}


