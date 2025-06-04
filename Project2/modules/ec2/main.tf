terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_instance" "public" {
  count                  = var.public_instance_count
  ami                    = data.aws_ami.redhat.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true
  key_name               = var.key_name

  tags = {
    Name = "${var.env_prefix}-pub-server"
  }
}

resource "aws_instance" "private" {
  count                  = var.private_instance_count
  ami                    = data.aws_ami.redhat.id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = false
  key_name               = var.key_name

  tags = {
    Name = "${var.env_prefix}-pri-server"
  }
}

data "aws_ami" "redhat" {
  most_recent = true
  owners      = ["309956199498"] # Red Hat's owner ID

  filter {
    name   = "name"
    values = ["RHEL-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Either add this filter for legacy boot mode
  filter {
    name   = "boot-mode"
    values = ["legacy-bios"]
  }
  
  # OR use this to explicitly exclude UEFI images
  filter {
    name   = "boot-mode"
    values = ["legacy-bios", ""] # Includes both legacy and unspecified
  }
}
