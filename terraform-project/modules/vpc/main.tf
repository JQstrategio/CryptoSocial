resource "aws_vpc" "crypto_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.vpc_enable_DNS
  tags = {
    Name = "${var.namespace}-vpc"
  }
}

resource "aws_internet_gateway" "crypto_igw" {
  vpc_id = aws_vpc.crypto_vpc.id
  tags = {
    Name = "${var.namespace}-igw"
  }
}

resource "aws_subnet" "crypto_public_subnet" {
  vpc_id            = aws_vpc.crypto_vpc.id
  cidr_block        = var.public_subnet
  availability_zone = var.subnet_az
  tags = {
    Name = "${var.namespace}-public"
  }
}

resource "aws_route_table" "crypto_public_rt" {
  vpc_id = aws_vpc.crypto_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.crypto_igw.id
  }
  tags = {
    Name = "${var.namespace}-prt"
  }
}

resource "aws_route_table_association" "add_public" {
  route_table_id = aws_route_table.crypto_public_rt.id
  subnet_id      = aws_subnet.crypto_public_subnet.id
}

# resource "aws_main_route_table_association" "main_route" {
#   vpc_id         = aws_vpc.crypto_vpc.id
#   route_table_id = aws_route_table.crypto_public_rt.id
# }

resource "aws_security_group" "allow_ssh" {
  name        = "crypto-allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.crypto_vpc.id

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Connect with port 8000"
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-sg"
  }
}