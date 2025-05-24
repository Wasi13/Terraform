# Providers
provider "aws" {
  alias  = "useast2"
  region = "us-east-2"
}

provider "aws" {
  alias  = "uswest2"
  region = "us-west-2"
}

# --- us-east-2 ---

# VPC
resource "aws_vpc" "east_vpc" {
  cidr_block = "10.10.0.0/16"
  provider   = aws.useast2
  tags = {
    Name = "VPC-us-east-2"
  }
}

# Subnets
resource "aws_subnet" "east_public" {
  vpc_id                  = aws_vpc.east_vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
  provider                = aws.useast2
  tags = {
    Name = "PublicSubnet-us-east-2"
  }
}

resource "aws_subnet" "east_private" {
  vpc_id            = aws_vpc.east_vpc.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "us-east-2b"
  provider          = aws.useast2
  tags = {
    Name = "PrivateSubnet-us-east-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "east_igw" {
  vpc_id   = aws_vpc.east_vpc.id
  provider = aws.useast2
  tags = {
    Name = "IGW-us-east-2"
  }
}

# Route Table and Association
resource "aws_route_table" "east_rt" {
  vpc_id   = aws_vpc.east_vpc.id
  provider = aws.useast2
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.east_igw.id
  }
  tags = {
    Name = "RouteTable-us-east-2"
  }
}

resource "aws_route_table_association" "east_assoc" {
  subnet_id      = aws_subnet.east_public.id
  route_table_id = aws_route_table.east_rt.id
  provider       = aws.useast2
}

# Security Group
resource "aws_security_group" "east_sg" {
  name        = "SG-us-east-2"
  description = "Allow SSH and ICMP"
  vpc_id      = aws_vpc.east_vpc.id
  provider    = aws.useast2

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

  tags = {
    Name = "SG-us-east-2"
  }
}

# EC2 Public Instance
resource "aws_instance" "east_public" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.east_public.id
  key_name                    = "RH_Key"
  vpc_security_group_ids      = [aws_security_group.east_sg.id]
  associate_public_ip_address = true
  provider                    = aws.useast2

  tags = {
    Name = "PublicInstance-us-east-2"
  }
}

# EC2 Private Instance
resource "aws_instance" "east_private" {
  ami                    = "ami-04f167a56786e4b09"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.east_private.id
  key_name               = "RH_Key"
  vpc_security_group_ids = [aws_security_group.east_sg.id]
  provider               = aws.useast2

  tags = {
    Name = "PrivateInstance-us-east-2"
  }
}

# --- us-west-2 ---

# VPC
resource "aws_vpc" "west_vpc" {
  cidr_block = "10.11.0.0/16"
  provider   = aws.uswest2
  tags = {
    Name = "VPC-us-west-2"
  }
}

# Subnets
resource "aws_subnet" "west_public" {
  vpc_id                  = aws_vpc.west_vpc.id
  cidr_block              = "10.11.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"
  provider                = aws.uswest2
  tags = {
    Name = "PublicSubnet-us-west-2"
  }
}

resource "aws_subnet" "west_private" {
  vpc_id            = aws_vpc.west_vpc.id
  cidr_block        = "10.11.2.0/24"
  availability_zone = "us-west-2b"
  provider          = aws.uswest2
  tags = {
    Name = "PrivateSubnet-us-west-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "west_igw" {
  vpc_id   = aws_vpc.west_vpc.id
  provider = aws.uswest2
  tags = {
    Name = "IGW-us-west-2"
  }
}

# Route Table and Association
resource "aws_route_table" "west_rt" {
  vpc_id   = aws_vpc.west_vpc.id
  provider = aws.uswest2
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.west_igw.id
  }
  tags = {
    Name = "RouteTable-us-west-2"
  }
}

resource "aws_route_table_association" "west_assoc" {
  subnet_id      = aws_subnet.west_public.id
  route_table_id = aws_route_table.west_rt.id
  provider       = aws.uswest2
}

# Security Group
resource "aws_security_group" "west_sg" {
  name        = "SG-us-west-2"
  description = "Allow SSH and ICMP"
  vpc_id      = aws_vpc.west_vpc.id
  provider    = aws.uswest2

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

  tags = {
    Name = "SG-us-west-2"
  }
}

# EC2 Public Instance
resource "aws_instance" "west_public" {
  ami                         = "ami-075686beab831bb7f"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.west_public.id
  key_name                    = "RH_Key1"
  vpc_security_group_ids      = [aws_security_group.west_sg.id]
  associate_public_ip_address = true
  provider                    = aws.uswest2

  tags = {
    Name = "PublicInstance-us-west-2"
  }
}

# EC2 Private Instance
resource "aws_instance" "west_private" {
  ami                    = "ami-075686beab831bb7f"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.west_private.id
  key_name               = "RH_Key1"
  vpc_security_group_ids = [aws_security_group.west_sg.id]
  provider               = aws.uswest2

  tags = {
    Name = "PrivateInstance-us-west-2"
  }
}
