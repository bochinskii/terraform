#
# VPC
#
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.env}"
  }
}

# Internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${var.env}-${aws_vpc.main.id}"
  }
}

# Subnets
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  count = length(var.public_subnet_cidr_blocks)
  cidr_block = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-public-${var.env}-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}

# Route tables (public)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rt-public-${var.env}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public[*].id)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "to_igw" {
  route_table_id = aws_route_table.public.id
  gateway_id = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}
