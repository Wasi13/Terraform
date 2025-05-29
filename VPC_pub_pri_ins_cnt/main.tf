provider "aws" {
  region = var.region
}

data "aws_ami" "redhat" {
  most_recent = true
  owners      = ["309956199498"] # Red Hat official account

  filter {
    name   = "name"
    values = ["RHEL-9*_HVM-*-x86_64-*"]
  }
}

resource "aws_vpc" "CS_VPC" {
  cidr_block = var.vpc_cidr
  tags = merge(var.tags, {
    Name = "CS_VPC-VPC"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.CS_VPC.id
  tags = merge(var.tags, {
    Name = "CS_VPC-IGW"
  })
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.CS_VPC.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = "${var.region}a"
  tags = merge(var.tags, {
    Name = "Public-Subnet"
  })
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.CS_VPC.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "${var.region}b"
  tags = merge(var.tags, {
    Name = "Private-Subnet"
  })
}

resource "aws_route_table" "public-subnet" {
  vpc_id = aws_vpc.CS_VPC.id
  tags = merge(var.tags, {
    Name = "Public-RT"
  })
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public-subnet.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public-subnet" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-subnet.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.CS_VPC.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "Allow-SSH"
  })
}

resource "aws_instance" "redhat" {
  count                     = var.instance_count
  ami                       = data.aws_ami.redhat.id
  instance_type             = var.instance_type
  key_name                  = var.key_name
  vpc_security_group_ids    = [aws_security_group.allow_ssh.id]

  # First N instances go to public subnet, rest go to private
  subnet_id                 = count.index < var.public_instance_count ? aws_subnet.public-subnet.id : aws_subnet.private-subnet.id
  associate_public_ip_address = count.index < var.public_instance_count ? true : false

  tags = merge(var.tags, {
    Name = count.index < var.public_instance_count ? "Public-EC2-${count.index}" : "Private-EC2-${count.index}"
  })
}

