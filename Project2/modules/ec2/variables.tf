variable "public_instance_count" {
  description = "Number of public instances to create"
  type        = number
  default     = 1
}

variable "private_instance_count" {
  description = "Number of private instances to create"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"  # Updated default to t3.micro
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group"
  type        = string
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
}

variable "env_prefix" {
  description = "Environment prefix for naming"
  type        = string
}
