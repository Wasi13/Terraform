provider "aws" {
  region = "ap-south-1"
}

# Create VPC
resource "aws_vpc" "Terraform_VPC" {
  cidr_block = "10.10.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Terraform_VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Terraform_VPC.id
  tags = {
    Name = "Terraform-igw"
  }
}

# Public Subnets
resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.Terraform_VPC.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.Terraform_VPC.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

# Private Subnets
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.Terraform_VPC.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.Terraform_VPC.id
  cidr_block        = "10.10.4.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "private-subnet-2"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.Terraform_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public-rt"
  }
}

# Associate Public Route Table with Public Subnets
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# Security Group for EC2 (Allow SSH and HTTP)
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.Terraform_VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# EC2 in Public Subnet
resource "aws_instance" "public_ec2" {
  ami           = "ami-03bb6d83c60fc5f7c"  # Windows 2019 in ap-south-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name      = "Key2"  # Replace with your key pair name
  tags = {
    Name = "public-instance"
  }
}

# EC2 in Private Subnet
resource "aws_instance" "private_ec2" {
  ami           = "ami-03bb6d83c60fc5f7c" # Windows 2019 in ap-south-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = false
  key_name      = "Key2"  # Replace with your key pair name
  tags = {
    Name = "private-instance"
  }
}
