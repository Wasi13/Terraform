output "public_instance_ip" {
  description = "Public IP of the public EC2 instance"
  value       = aws_instance.public_instance.public_ip
}

output "private_instance_id" {
  description = "Instance ID of the private EC2 instance"
  value       = aws_instance.private_instance.id
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

