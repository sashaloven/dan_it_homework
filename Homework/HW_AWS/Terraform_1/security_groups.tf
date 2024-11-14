resource "aws_security_group" "lov_sg_ssh" {
  name        = "lov_sg_ssh"
  description = "allow_ssh_from_anywhere"
  vpc_id      = aws_vpc.lov_vpc.id

  ingress {
    description = "Allow SSH from anywhere"
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

  tags = var.tags
}
