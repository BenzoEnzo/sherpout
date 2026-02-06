resource "aws_vpc" "tst_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "sherpout-tst-vpc",
    ManagedBy = "Terraform"
  })
}

resource "aws_subnet" "tst_public_subnet" {
  vpc_id = aws_vpc.tst_vpc.id
  cidr_block = var.subnet_cidr_block
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "sherpout-tst-subnet",
    ManagedBy = "Terraform"
  })
}

resource "aws_subnet" "tst_private_subnet_1" {
  vpc_id                  = aws_vpc.tst_vpc.id
  cidr_block              = var.private_subnet_cidr_block[0]
  map_public_ip_on_launch = false
  availability_zone       = "eu-north-1a"

  tags = merge(var.tags, {
    Name = "sherpout-tst-private-subnet",
    ManagedBy = "Terraform"
  })
}

resource "aws_subnet" "tst_private_subnet_2" {
  vpc_id                  = aws_vpc.tst_vpc.id
  cidr_block              = var.private_subnet_cidr_block[1]
  map_public_ip_on_launch = false
  availability_zone       = "eu-north-1b"

  tags = merge(var.tags, {
    Name = "sherpout-tst-private-subnet",
    ManagedBy = "Terraform"
  })
}

resource "aws_internet_gateway" "tst" {
  vpc_id = aws_vpc.tst_vpc.id
  tags = var.tags
}

resource "aws_route_table" "tst" {
  vpc_id = aws_vpc.tst_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tst.id
  }
  tags = merge(var.tags, {
    Name = "public route table"
  })
}

resource "aws_route_table_association" "tst" {
  subnet_id = aws_subnet.tst_public_subnet.id
  route_table_id = aws_route_table.tst.id
}

resource "aws_db_subnet_group" "postgres_subnet" {
  name       = "postgres-subnet-group"
  subnet_ids = [aws_subnet.tst_private_subnet_1.id,
                aws_subnet.tst_private_subnet_2.id]

  tags = merge(var.tags, {
    Name = "postgres-subnet-group"
  })
}