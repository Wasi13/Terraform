variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.25.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.25.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.25.2.0/24"
}

variable "key_name" {
  default = "Key2"
}

variable "instance_count" {
  default = 6
}

variable "public_instance_count" {
  description = "Number of EC2 instances in the public subnet"
  type        = number
  default     = 3
}

variable "instance_type" {
  default = "t2.micro"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Dev"
    Project     = "Terraform-RedHat-Infra"
  }
}
