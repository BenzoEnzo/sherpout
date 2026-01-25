resource "aws_vpc" "tst" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "sherpout-tst-vpc",
    ManagedBy = "Terraform"
  })
}

resource "aws_subnet" "tst" {
  vpc_id = aws_vpc.tst.id
  cidr_block = var.subnet_cidr_block
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "sherpout-tst-subnet",
    ManagedBy = "Terraform"
  })
}

resource "aws_internet_gateway" "tst" {
  vpc_id = aws_vpc.tst.id
  tags = var.tags
}

resource "aws_route_table" "tst" {
  vpc_id = aws_vpc.tst.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tst.id
  }
  tags = merge(var.tags, {
    Name = "public route table"
  })
}

resource "aws_route_table_association" "tst" {
  subnet_id = aws_subnet.tst.id
  route_table_id = aws_route_table.tst.id
}