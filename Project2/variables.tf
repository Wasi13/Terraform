variable "east_region" {
  description = "AWS region for east resources"
  default     = "us-east-1"
}

variable "west_region" {
  description = "AWS region for west resources"
  default     = "us-west-1"
}

variable "east_vpc_cidr" {
  description = "CIDR block for east VPC"
  default     = "10.30.0.0/16"
}

variable "west_vpc_cidr" {
  description = "CIDR block for west VPC"
  default     = "10.31.0.0/16"
}

variable "east_public_subnet_cidr" {
  description = "CIDR block for east public subnet"
  default     = "10.30.1.0/24"
}

variable "east_private_subnet_cidr" {
  description = "CIDR block for east private subnet"
  default     = "10.30.2.0/24"
}

variable "west_public_subnet_cidr" {
  description = "CIDR block for west public subnet"
  default     = "10.31.1.0/24"
}

variable "west_private_subnet_cidr" {
  description = "CIDR block for west private subnet"
  default     = "10.31.2.0/24"
}

variable "public_instance_count" {
  description = "Number of public instances to create in each region"
  default     = 1
}

variable "private_instance_count" {
  description = "Number of private instances to create in each region"
  default     = 1
}
