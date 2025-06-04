terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "east"
}

provider "aws" {
  region = "us-west-1"
  alias  = "west"
}

module "east_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.east
  }

  vpc_cidr            = var.east_vpc_cidr
  vpc_name            = "Dev-east-vpc"
  public_subnet_cidr  = var.east_public_subnet_cidr
  private_subnet_cidr = var.east_private_subnet_cidr
  public_az           = "${var.east_region}a"
  private_az          = "${var.east_region}b"
}

module "east_sg" {
  source = "./modules/security-group"
  providers = {
    aws = aws.east
  }

  sg_name = "Dev-east-sg"
  vpc_id  = module.east_vpc.vpc_id
}

module "east_ec2" {
  source = "./modules/ec2"
  providers = {
    aws = aws.east
  }

  public_instance_count  = var.public_instance_count
  private_instance_count = var.private_instance_count
  public_subnet_id       = module.east_vpc.public_subnet_id
  private_subnet_id      = module.east_vpc.private_subnet_id
  security_group_id      = module.east_sg.security_group_id
  key_name               = "EastKey"
  env_prefix             = "Dev-east"
}

module "west_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.west
  }

  vpc_cidr            = var.west_vpc_cidr
  vpc_name            = "Dev-west-vpc"
  public_subnet_cidr  = var.west_public_subnet_cidr
  private_subnet_cidr = var.west_private_subnet_cidr
  public_az           = "${var.west_region}a"
  private_az          = "${var.west_region}b"
}

module "west_sg" {
  source = "./modules/security-group"
  providers = {
    aws = aws.west
  }

  sg_name = "Dev-west-sg"
  vpc_id  = module.west_vpc.vpc_id
}

module "west_ec2" {
  source = "./modules/ec2"
  providers = {
    aws = aws.west
  }

  public_instance_count  = var.public_instance_count
  private_instance_count = var.private_instance_count
  public_subnet_id       = module.west_vpc.public_subnet_id
  private_subnet_id      = module.west_vpc.private_subnet_id
  security_group_id      = module.west_sg.security_group_id
  key_name               = "WestKey"
  env_prefix             = "Dev-west"
}
