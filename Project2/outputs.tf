output "east_public_instances" {
  value = module.east_ec2.public_instance_ids
}

output "east_private_instances" {
  value = module.east_ec2.private_instance_ids
}

output "west_public_instances" {
  value = module.west_ec2.public_instance_ids
}

output "west_private_instances" {
  value = module.west_ec2.private_instance_ids
}
