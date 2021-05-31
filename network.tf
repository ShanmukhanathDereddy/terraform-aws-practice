#Network Configuration

#VPC Creation
resource "aws_vpc" "terraform" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-http"
  }
}

#http instance subnet configuration
resource "aws_subnet" "http" {
  vpc_id            = aws_vpc.terraform.id
  cidr_block        = var.network_http["cidr"]
  availability_zone = var.availability_zone_names[0]
  tags = {
    Name = "subnet-http"
  }
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_subnet" "http-1" {
  vpc_id            = aws_vpc.terraform.id
  cidr_block        = var.network_http["cidr"]
  availability_zone = var.availability_zone_names[1]
  tags = {
    Name = "subnet-http"
  }
  depends_on = [aws_internet_gateway.gw]
}

#db instance subnet configuration
resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.terraform.id
  cidr_block        = var.network_db["cidr"]
  availability_zone = var.availability_zone_names[0]
  tags = {
    Name = "subnet-db"
  }
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_subnet" "db-1" {
  vpc_id            = aws_vpc.terraform.id
  cidr_block        = var.network_db["cidr"]
  availability_zone = var.availability_zone_names[1]
  tags = {
    Name = "subnet-db"
  }
  depends_on = [aws_internet_gateway.gw]
}

#changing main route table
resource "aws_main_route_table_association" "tf" {
  vpc_id         = aws_vpc.terraform.id
  route_table_id = aws_route_table.public.id
}

#External Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform.id
  tags = {
    Name = "terraform-igw"
  }
}
