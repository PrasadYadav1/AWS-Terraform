# Define the AWS provider
provider "aws" {
  region = "us-west-2" # Update with your preferred region
}

# Create a VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16" # Update with your preferred CIDR block
}

# Create public subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24" # Update with your preferred CIDR block
  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.2.0/24" # Update with your preferred CIDR block
  tags = {
    Name = "Public Subnet 2"
  }
}

# Create private subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.3.0/24" # Update with your preferred CIDR block
  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.4.0/24" # Update with your preferred CIDR block
  tags = {
    Name = "Private Subnet 2"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
}

# Create a routing table
resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
}

# Associate public subnets with the routing table
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.example_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.example_route_table.id
}

# Create a NAT gateway
resource "aws_nat_gateway" "example_nat_gateway" {
  allocation_id = aws_eip.example_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
}

# Create an Elastic IP for the NAT gateway
resource "aws_eip" "example_eip" {}

# Associate private subnets with the routing table
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.example_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.example_route_table.id
}

#
