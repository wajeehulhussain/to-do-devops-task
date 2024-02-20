#VPC Declaration
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name  = "${var.project}-vpc"
    Owner = var.owner
  }
}

#Public subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name  = format("%s-%s-%s", var.project, var.public_subnet_name, count.index)
    Owner = var.owner
    Type  = var.public_subnet_name
  }
}

# Private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name                                                                            = format("%s-%s-%s", var.project, var.private_subnet_name, count.index)
    Owner                                                                           = var.owner
    Type                                                                            = var.private_subnet_name
    format("%s/%s", var.kubernetes_url, var.role_path)                              = var.elb_value
    format("%s/%s/%s", var.kubernetes_url, var.resource_type, var.eks_cluster_name) = var.type
  }
}

#Internet Gateway
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name  = "${var.project}-igw"
    Owner = var.owner
  }
}

#Locals for Fetching Public and Private Subnet IDs
locals {
  private_subnet_ids = [for private_subnet in aws_subnet.private_subnets : private_subnet.id]
}
locals {
  public_subnet_ids = [for public_subnet in aws_subnet.public_subnets : public_subnet.id]
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.rtb_cidr
    gateway_id = aws_internet_gateway.vpc_igw.id
  }
  tags = {
    Name  = "${var.project}-public-rtb"
    Owner = var.owner
  }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name  = "${var.project}-private-rtb"
    Owner = var.owner
  }
}

#Public Route Table Association
resource "aws_route_table_association" "rtb_asso_public_subnet" {
  count          = length(local.public_subnet_ids)
  route_table_id = aws_route_table.public.id
  subnet_id      = local.public_subnet_ids[count.index]
}

#Private Route Table Association
resource "aws_route_table_association" "rtb_asso_private_subnet" {
  count          = length(local.private_subnet_ids)
  route_table_id = aws_route_table.private.id
  subnet_id      = local.private_subnet_ids[count.index]
}

# Elastic IP for NAT GW
resource "aws_eip" "nat_gateway_eip" {
  tags = {
    Name  = "${var.project}-nat-gw"
    Owner = var.owner
  }
}

#NAT GW Declaration in Public Subnet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = local.public_subnet_ids[0]
  tags = {
    Name  = "${var.project}-nat-gw"
    Owner = var.owner
  }
}

# NAT GW Route Entry into the Private Route Table
resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = var.rtb_cidr
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}