output "public_subnet_out" {
    value = aws_subnet.public_subnets[*].id
}


output "private_subnet_out" {
  value = aws_subnet.private_subnets[*].id
}
