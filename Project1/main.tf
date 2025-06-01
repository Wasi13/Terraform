provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.50.0.0/16"
  public_subnet_cidr = "10.50.1.0/24"
  private_subnet_cidr = "10.50.2.0/24"
  
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "my-sg"
  }
}

module "ec2" {
  source = "./modules/ec2"

  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  sg_id             = module.security_group.sg_id
  key_name          = "Key2"
  instance_count_public  = 2
  instance_count_private = 2
  ami_id = "ami-062f1e554cd8612c6" # RHEL 9 in ap-south-1
  tags = {
    Project = "TerraformProject"
  }
}
