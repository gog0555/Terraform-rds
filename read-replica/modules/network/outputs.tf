output "vpc_id" {
    value = aws_vpc.main.id
}

output "public_subnet" {
  value = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet" {
  value = [for subnet in aws_subnet.private_subnet : subnet.id]
}
