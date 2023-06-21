module "ssh_sg" {
  source = "../.."

  name = var.name
  description = var.description
  vpc_id = var.vpc_id
  ingress_rules = [
    {
      description      = "SSH allow"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
    }
  ]
}