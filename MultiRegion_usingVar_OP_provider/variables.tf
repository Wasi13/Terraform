variable "key_pair_use2" {
  default = "RH_Key"
}

variable "key_pair_usw2" {
  default = "RH_Key1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "tags" {
  default = {
    Environment = "Dev"
    Owner       = "Terraform"
    Project     = "MultiRegion"
  }
}

