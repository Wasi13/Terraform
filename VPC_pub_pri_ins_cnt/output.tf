# Public EC2 IPs (2 instances)
output "public_ec2_ips" {
  value       = [for i in aws_instance.redhat : i.public_ip if i.associate_public_ip_address]
  description = "List of Public EC2 IP addresses"
}

# Private EC2 IDs (2 instances)
output "private_ec2_ids" {
  value       = [for i in aws_instance.redhat : i.id if !i.associate_public_ip_address]
  description = "List of Private EC2 instance IDs"
}

# VPC ID
output "vpc_id" {
  value       = aws_vpc.CS_VPC.id
  description = "VPC ID"
}

# Subnet IDs
output "subnet_ids" {
  value       = [aws_subnet.public-subnet.id, aws_subnet.private-subnet.id]
  description = "Public and Private Subnet IDs"
}
