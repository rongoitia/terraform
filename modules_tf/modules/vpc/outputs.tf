### VPC
output "default_sg_id" {
  value       = aws_default_security_group.default.id
}

output "vpc_id" {
  value       = aws_vpc.main.id
}

### Public Subnets
output "public-a-id" {
  value       = aws_subnet.public-a.id
}

output "public-b-id" {
  value       = aws_subnet.public-b.id
}

output "public-c-id" {
  value       = aws_subnet.public-c.id
}

### Private Subnets
output "private-a-id" {
  value       = aws_subnet.private-a.id
}

output "private-b-id" {
  value       = aws_subnet.private-b.id
}

output "private-c-id" {
  value       = aws_subnet.private-c.id
}
