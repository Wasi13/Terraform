variable "public_subnet_id" {}
variable "private_subnet_id" {}
variable "sg_id" {}
variable "key_name" {}
variable "instance_count_public" {}
variable "instance_count_private" {}
variable "ami_id" {}
variable "tags" { type = map(string) }
