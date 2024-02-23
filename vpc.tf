# VPC
resource "aws_vpc" "Deham10_VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Deham10_VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Deham10_VPC.id

  tags = {
    Name = "MyInternetGateway"
  }
}


# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.Deham10_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.Deham10_VPC.id

  tags = {
    Name = "Private Route Table"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.Deham10_VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Public Subnet"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.Deham10_VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Private Subnet"
  }
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
