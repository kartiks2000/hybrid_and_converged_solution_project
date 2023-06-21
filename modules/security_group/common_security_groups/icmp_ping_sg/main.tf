module "icmp_sg" {
  source = "../.."

  name = var.name
  description = var.description
  vpc_id = var.vpc_id
  ingress_rules = [
    {
      description      = "Ping allow"
      from_port = -1
      to_port = -1
      protocol = "icmp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
    }
  ]
  egress_rules = [{
    description      = "Ping allow"
      from_port = -1
      to_port = -1
      protocol = "icmp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
  }]
}