# Create VPC, Nat gt, internet gt, subnets, route_table, aws_eip, route, aws_route_table_association

resource "aws_vpc" "lov_vpc" {
    cidr_block          = "10.0.0.0/24"
    enable_dns_support  = true
    enable_dns_hostnames = true
    tags = {
    Name = "lov_vpc"
  }
}

resource "aws_internet_gateway" "lov_igw" {
  vpc_id = aws_vpc.lov_vpc.id
  tags = var.tags
}

resource "aws_eip" "lov_nat_ip" {
  domain = "vpc"
  tags = var.tags
}

resource "aws_nat_gateway" "lov_nat_gw" {
  allocation_id = aws_eip.lov_nat_ip.id
  subnet_id     = aws_subnet.lov_public_subnet_1.id
  tags = var.tags
}

resource "aws_subnet" "lov_public_subnet_1" {
  vpc_id     = aws_vpc.lov_vpc.id
  cidr_block = "10.0.0.0/25"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Jenkins-master"
  }
}

resource "aws_subnet" "lov_private_subnet_1" {
  vpc_id     = aws_vpc.lov_vpc.id
  cidr_block = "10.0.0.128/25"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "Jenkins-worker"
  }
}

resource "aws_route_table" "lov_rt" {
  vpc_id = aws_vpc.lov_vpc.id
  tags = var.tags
}

resource "aws_route" "lov_public_rt" {
  route_table_id         = aws_route_table.lov_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lov_igw.id
}

resource "aws_route_table_association" "public-subnet-1-association" {
  subnet_id      = aws_subnet.lov_public_subnet_1.id
  route_table_id = aws_route_table.lov_rt.id
}


# Create Security group what allow_ssh_and_http_from_anywhere

resource "aws_security_group" "lov_sg_ssh" {
  name        = "lov_sg_ssh"
  description = "allow_ssh_and_http_from_anywhere"
  vpc_id      = aws_vpc.lov_vpc.id

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# Create aws_key_pair from "~/.ssh/id_rsa.pub"

resource "aws_key_pair" "ssh_key" {
  key_name   = "lovyniuk_key_step3"
  public_key = file("~/.ssh/id_rsa.pub")
}


# Create 2 ec2 ubuntu instances 

resource "aws_instance" "public-instance-1" {
  ami                          = var.ami
  instance_type                = var.instance_type
  subnet_id                    = aws_subnet.lov_public_subnet_1.id
  associate_public_ip_address  = true
  key_name                     = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.lov_sg_ssh.id]
   tags = {
    Name = "Jenkins-master"
  }
}

  resource "aws_instance" "public-instance-2" {
  ami                          = var.ami
  instance_type                = var.instance_type
  subnet_id                    = aws_subnet.lov_public_subnet_1.id
  associate_public_ip_address  = true
  key_name                     = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.lov_sg_ssh.id]
   tags = {
    Name = "Jenkins-worker"
  }

  # Can add pub ssh key, but I use key from ~/.ssh/id_rsa.pub
  # user_data = <<-EOF
  #            #!/bin/bash
  #            mkdir -p /home/ubuntu/.ssh
  #            echo "YOUR_PUBLIC_SSH_KEY_HERE" >> /home/ubuntu/.ssh/authorized_keys
  #            chmod 600 /home/ubuntu/.ssh/authorized_keys
  #            chown -R ubuntu:ubuntu /home/ubuntu/.ssh
  #            EOF

}

