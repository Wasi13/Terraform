output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_instance_id" {
  value = aws_instance.redhat_instances[0].id
}

output "private_instance_id" {
  value = aws_instance.redhat_instances[1].id
}

output "public_ip" {
  value = aws_instance.redhat_instances[0].public_ip
}

output "key_pair_used" {
  value = var.key_name
}

output "all_instance_ids" {
  value = [for instance in aws_instance.redhat_instances : instance.id]
}

output "public_ips" {
  value = [for instance in aws_instance.redhat_instances : instance.public_ip]
}

