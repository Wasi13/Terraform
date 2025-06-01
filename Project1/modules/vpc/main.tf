resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = "myvpc"
    Environment = "Dev"
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myigw"
    Environment = "Dev"
  }
}

resource "aws_subnet" "my-pub-sub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-pub-sub"
    Environment = "Dev"
  }
}

resource "aws_subnet" "my-pri-sub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "ap-south-1b"
  tags = {
    Name = "my-pri-sub"
    Environment = "Dev"
  }
}

resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "myrt"
    Environment = "Dev"
  }
}

resource "aws_route_table_association" "myrt" {
  subnet_id      = aws_subnet.my-pub-sub.id
  route_table_id = aws_route_table.myrt.id
}
