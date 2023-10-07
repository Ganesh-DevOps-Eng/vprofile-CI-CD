# VPC
resource "aws_vpc" "vprofile_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidr_blocks)
  vpc_id            = aws_vpc.vprofile_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = element(data.aws_availability_zones.zone.names, count.index)
  tags = {
    Name = "Public_Subnet_${count.index + 1}"

  }
}

# Private Subnets
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.vprofile_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = element(data.aws_availability_zones.zone.names, count.index)
  tags = {
    Name = "Private_Subnet_${count.index + 1}"
    # Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "vprofile_gateway" {
  vpc_id = aws_vpc.vprofile_vpc.id

  tags = {
    Name = "vprofile-i-Gateway"
  }
}

# Public Routing Tables
resource "aws_route_table" "public_routing_table" {
  count  = length(var.public_subnet_cidr_blocks)
  vpc_id = aws_vpc.vprofile_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vprofile_gateway.id
  }
  # subnet_ids = [aws_subnet.public_subnet[count.index].id]

  tags = {
    Name = "Public_Routing_Tables_${count.index + 1}"
  }
}

# Private Routing Tables
resource "aws_route_table" "private_routing_table" {
  count  = length(var.private_subnet_cidr_blocks)
  vpc_id = aws_vpc.vprofile_vpc.id
  # subnet_ids = [aws_subnet.private_subnet[count.index].id]

  tags = {
    Name = "Private_Routing_Table_${count.index + 1}"

  }
}

# Associate Private Routing Tables with Private Subnets
resource "aws_route_table_association" "private_routing_table_association" {
  count          = length(var.private_subnet_cidr_blocks)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_routing_table[count.index].id
}


# Associate Public Routing Tables with Public Subnets
resource "aws_route_table_association" "public_routing_table_association" {
  count          = length(var.public_subnet_cidr_blocks)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_routing_table[count.index].id
}

