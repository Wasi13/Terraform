output "public_ec2_ip" {
  value = aws_instance.redhat[0].public_ip
  description = "Public EC2 IP address"
}

output "private_ec2_id" {
  value = aws_instance.redhat[1].id
  description = "Private EC2 instance ID"
}

output "vpc_id" {
  value = aws_vpc.CS_VPC.id
}

output "subnet_ids" {
  value = [aws_subnet.public-Subnet.id, aws_subnet.private-Subnet.id]
}
