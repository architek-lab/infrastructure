
resource "aws_vpc" "architek_vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = merge(
    { Name = "architek-vpc" },
    local.common_tags
  )
}

resource "aws_internet_gateway" "architek_vpc_igw" {
  vpc_id = aws_vpc.architek_vpc.id

  tags = merge(
    { Name = "architek-vpc-igw" },
    local.common_tags
  )
}


resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.architek_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = merge(
    { Name = "architek-vpc-public-subnet-a" },
    local.common_tags
  )

}


resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.architek_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = merge(
    { Name = "architek-vpc-public-subnet-b" },
    local.common_tags
  )

}


resource "aws_route_table" "public_subnet_rtb" {
  vpc_id = aws_vpc.architek_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.architek_vpc_igw.id
  }

  tags = merge(
    { Name = "public-subnet-rtb" },
    local.common_tags
  )

}

resource "aws_route_table_association" "rtb_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_subnet_rtb.id
}

resource "aws_route_table_association" "rtb_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_subnet_rtb.id
}

