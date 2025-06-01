resource "aws_instance" "public-server" {
  count         = var.instance_count_public
  ami           = var.ami_id
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [var.sg_id]
  key_name      = var.key_name
  associate_public_ip_address = true

  tags = merge(var.tags, {
    Name = "public-server-${count.index + 1}"
  })
}

resource "aws_instance" "private-server" {
  count         = var.instance_count_private
  ami           = var.ami_id
  instance_type = "t3.micro"
  subnet_id     = var.private_subnet_id
  vpc_security_group_ids = [var.sg_id]
  key_name      = var.key_name

  tags = merge(var.tags, {
    Name = "private-server-${count.index + 1}"
  })
}
