resource "aws_vpc" "use2_vpc" {
  provider   = aws.use2
  cidr_block = "10.20.0.0/16"
  tags       = merge(var.tags, { Name = "use2-vpc" })
}

resource "aws_subnet" "use2_public" {
  provider                = aws.use2
  vpc_id                  = aws_vpc.use2_vpc.id
  cidr_block              = "10.20.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
  tags                    = merge(var.tags, { Name = "use2-public-subnet" })
}

resource "aws_subnet" "use2_private" {
  provider          = aws.use2
  vpc_id            = aws_vpc.use2_vpc.id
  cidr_block        = "10.20.2.0/24"
  availability_zone = "us-east-2b"
  tags              = merge(var.tags, { Name = "use2-private-subnet" })
}

resource "aws_internet_gateway" "use2_igw" {
  provider = aws.use2
  vpc_id   = aws_vpc.use2_vpc.id
  tags     = merge(var.tags, { Name = "use2-igw" })
}

resource "aws_route_table" "use2_rt" {
  provider = aws.use2
  vpc_id   = aws_vpc.use2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.use2_igw.id
  }

  tags = merge(var.tags, { Name = "use2-route-table" })
}

resource "aws_route_table_association" "use2_rta" {
  provider       = aws.use2
  subnet_id      = aws_subnet.use2_public.id
  route_table_id = aws_route_table.use2_rt.id
}

resource "aws_security_group" "use2_sg" {
  provider = aws.use2
  name     = "use2-sg"
  vpc_id   = aws_vpc.use2_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "use2-sg" })
}

data "aws_ami" "use2_ubuntu" {
  provider    = aws.use2
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "use2_public" {
  provider                    = aws.use2
  ami                         = data.aws_ami.use2_ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.use2_public.id
  associate_public_ip_address = true
  key_name                    = var.key_pair_use2
  security_groups             = [aws_security_group.use2_sg.id]
  tags                        = merge(var.tags, { Name = "use2-public-instance" })
}

resource "aws_instance" "use2_private" {
  provider        = aws.use2
  ami             = data.aws_ami.use2_ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.use2_private.id
  key_name        = var.key_pair_use2
  security_groups = [aws_security_group.use2_sg.id]
  tags            = merge(var.tags, { Name = "use2-private-instance" })
}

resource "aws_vpc" "usw2_vpc" {
  provider   = aws.usw2
  cidr_block = "10.21.0.0/16"
  tags       = merge(var.tags, { Name = "usw2-vpc" })
}

resource "aws_subnet" "usw2_public" {
  provider                = aws.usw2
  vpc_id                  = aws_vpc.usw2_vpc.id
  cidr_block              = "10.21.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"
  tags                    = merge(var.tags, { Name = "usw2-public-subnet" })
}

resource "aws_subnet" "usw2_private" {
  provider          = aws.usw2
  vpc_id            = aws_vpc.usw2_vpc.id
  cidr_block        = "10.21.2.0/24"
  availability_zone = "us-west-2b"
  tags              = merge(var.tags, { Name = "usw2-private-subnet" })
}

resource "aws_internet_gateway" "usw2_igw" {
  provider = aws.usw2
  vpc_id   = aws_vpc.usw2_vpc.id
  tags     = merge(var.tags, { Name = "usw2-igw" })
}

resource "aws_route_table" "usw2_rt" {
  provider = aws.usw2
  vpc_id   = aws_vpc.usw2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.usw2_igw.id
  }

  tags = merge(var.tags, { Name = "usw2-route-table" })
}

resource "aws_route_table_association" "usw2_rta" {
  provider       = aws.usw2
  subnet_id      = aws_subnet.usw2_public.id
  route_table_id = aws_route_table.usw2_rt.id
}

resource "aws_security_group" "usw2_sg" {
  provider = aws.usw2
  name     = "usw2-sg"
  vpc_id   = aws_vpc.usw2_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "usw2-sg" })
}

data "aws_ami" "usw2_ubuntu" {
  provider    = aws.usw2
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "usw2_public" {
  provider                    = aws.usw2
  ami                         = data.aws_ami.usw2_ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.usw2_public.id
  associate_public_ip_address = true
  key_name                    = var.key_pair_usw2
  security_groups             = [aws_security_group.usw2_sg.id]
  tags                        = merge(var.tags, { Name = "usw2-public-instance" })
}

resource "aws_instance" "usw2_private" {
  provider        = aws.usw2
  ami             = data.aws_ami.usw2_ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.usw2_private.id
  key_name        = var.key_pair_usw2
  security_groups = [aws_security_group.usw2_sg.id]
  tags            = merge(var.tags, { Name = "usw2-private-instance" })
}
