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
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "lov_private_subnet_1" {
  vpc_id     = aws_vpc.lov_vpc.id
  cidr_block = "10.0.0.128/25"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "private-subnet-1"
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