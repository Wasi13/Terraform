variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.11.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.11.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  default     = "10.11.2.0/24"
}

variable "availability_zone" {
  description = "Availability zone"
  default     = "ap-south-1a"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

