provider "aws" {
    region = var.region
    profile = var.profile
}

data "aws_availability_zones" "main" {}

data "aws_region" "current" {}

locals {
  azs = length(var.availability_zones) > 0 ? var.availability_zones : data.aws_availability_zones.main.names
}

resource "aws_vpc" "main" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = var.enable_dns_hostnames

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name_prefix}-vpc"
    },
  )
}

resource "aws_internet_gateway" "public" {
  depends_on = [aws_vpc.main]
  vpc_id     = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name_prefix}-public-igw"
    },
  )
}

resource "aws_route_table" "public" {
  #count      = length(var.public_subnet_cidrs) > 0 ? 1 : 0
  #count      = length(var.public_subnet_cidrs)
  depends_on = [aws_vpc.main]
  vpc_id     = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name_prefix}-public-rt"
    },
  )
}

resource "aws_route" "public" {
  #count = length(var.public_subnet_cidrs) > 0 ? 1 : 0
  depends_on = [
    aws_internet_gateway.public,
    aws_route_table.public,
  ]
  #route_table_id         = aws_route_table.public[0].id
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.public.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_subnet" "public" {
  count                           = length(var.public_subnet_cidrs)
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = var.public_subnet_cidrs[count.index]
  availability_zone               = element(local.azs, count.index)
  map_public_ip_on_launch         = true

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name_prefix}-public-subnet-${count.index + 1}"
      "Tier" = "Public"
    },
  )
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  #route_table_id = aws_route_table.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "private" {
  #count = local.nat_gateway_count

  tags = merge(
    var.tags,
    {
      #"Name" = "${var.name_prefix}-nat-gateway-${count.index + 1}"
      "Name" = "${var.name_prefix}-nat-gateway"
    },
  )
}

resource "aws_nat_gateway" "private" {
  depends_on = [
    aws_internet_gateway.public,
    aws_eip.private,
  ]
  #count         = local.nat_gateway_count
  #allocation_id = aws_eip.private[count.index].id
  #subnet_id     = element(aws_subnet.public[*].id, count.index)
  allocation_id = aws_eip.private.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.tags,
    {
      #"Name" = "${var.name_prefix}-nat-gateway-${count.index + 1}"
      "Name" = "${var.name_prefix}-nat-gateway"
    },
  )
}

resource "aws_route_table" "private" {
  depends_on = [aws_vpc.main]
  #count      = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      #"Name" = "${var.name_prefix}-private-rt-${count.index + 1}"
      "Name" = "${var.name_prefix}-private-rt"
    },
  )
}

resource "aws_route" "private" {
  depends_on = [
    aws_nat_gateway.private,
    aws_route_table.private,
  ]
  #count                  = local.nat_gateway_count > 0 ? length(var.private_subnet_cidrs) : 0
  #count                  = length(var.private_subnet_cidrs)
  #route_table_id         = aws_route_table.private[count.index].id
  route_table_id         = aws_route_table.private.id
  #nat_gateway_id         = element(aws_nat_gateway.private[*].id, count.index)
  nat_gateway_id         = aws_nat_gateway.private.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_subnet" "private" {
  count                           = length(var.private_subnet_cidrs)
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = var.private_subnet_cidrs[count.index]
  availability_zone               = element(local.azs, count.index)
  map_public_ip_on_launch         = false

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name_prefix}-private-subnet-${count.index + 1}"
      "Tier" = "Private"
    },
  )
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  #route_table_id = aws_route_table.private[count.index].id
  route_table_id = aws_route_table.private.id
}