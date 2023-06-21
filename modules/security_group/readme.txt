parameters:
- name (mandatory)
- description (optional), default: ""
- vpc_id (mandatory)

- ingress_rules (mandatory)

  input structure:
  list(object({
    description = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
    ipv6_cidr_blocks = list(string)
  }))


- egress_rules (optional)

  default:
  [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }]

  input structure:
  list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
    ipv6_cidr_blocks = list(string)
  }))

