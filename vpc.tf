resource "aws_vpc" "main" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = "ta-mikes-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "talent-academy-igw"
  }
}

resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "nat gate pub"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat_eip" {
  vpc = true
}


#Public Subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat_gateway.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

# Associate Private Subnet 1 to "App Layer"
resource "aws_route_table_association" "private-subnet-1-route-table-association-App" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

# Associate Private Subnet 2 to "App Layer"
resource "aws_route_table_association" "private-subnet-2-route-table-association-App" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}



#Private Subnets
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 1 | App layer"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private-subnet-2-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 2 | Data layer"
  }
}

# resource "aws_dynamodb_table" "terraform_lock_tbl" {
#   name           = "terraform-lock"
#   read_capacity  = 1
#   write_capacity = 1
#   hash_key       = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags           = {
#     Name = "terraform-lock"
#   }
# }