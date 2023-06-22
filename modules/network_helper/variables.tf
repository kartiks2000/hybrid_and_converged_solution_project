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

variable "internet_gateway_name" {
  type = string
  default = "igw"
}

variable "public_route_table_name" {
  type = string
  default = "Public_RT"
}


variable "private_route_table_name" {
  type = string
  default = "Private_RT"
}

variable "internet_gateway_route_destination_cidr" {
  type = string
  default = "0.0.0.0/0"
}

variable "nat_gateway_name" {
  type = string
  default = "nat_gw"
}

variable "nat_route_destination_cidr" {
  type = string
  default = "0.0.0.0/0"
}

