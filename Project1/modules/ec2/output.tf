output "public_instance_ids" {
  value = aws_instance.public-server[*].id
}

output "private_instance_ids" {
  value = aws_instance.private-server[*].id
}
