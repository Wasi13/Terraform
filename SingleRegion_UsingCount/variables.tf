variable "aws_region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "10.21.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.21.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.21.2.0/24"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "RH_Key"
}

variable "ami_id" {
  description = "Red Hat AMI ID in us-east-2"
  default     = "ami-0fe07c1aadd2e4ac9" # Red Hat Enterprise Linux version 10 (HVM)
}

variable "tags" {
  default = {
    Environment = "Dev"
    Owner       = "Terraform"
  }
}

