resource "aws_instance" "private-instance" {
  ami             = "ami-0084a47cc718c111a"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.lov_private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.lov_sg_ssh.id]
  key_name                     = "lovyniuk-key"
   tags = {
    Name = "private-instance"
  }
}

resource "aws_instance" "public-instance" {
  ami                          = "ami-0084a47cc718c111a"
  instance_type                = "t2.micro"
  subnet_id                    = aws_subnet.lov_public_subnet_1.id
  associate_public_ip_address  = true
  key_name                     = "lovyniuk-key"
  vpc_security_group_ids = [aws_security_group.lov_sg_ssh.id]
   tags = {
    Name = "public-instance"
  }
}