output "public_ip" {
  value = aws_instance.web.public_ip
}

output "arn" {
  value = aws_instance.web.ami
}

output "availability_zone" {
  value = aws_instance.web.availability_zone
}

output "security_group_ids" {
  value = tolist(aws_instance.web.vpc_security_group_ids)
}

output "subnet_id" {
  value = aws_instance.web.subnet_id
}

output "id" {
  value = aws_instance.web.id
}

