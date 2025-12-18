resource "aws_vpc" "main" {

  cidr_block = local.vpc_cidr
  enable_dns_hostnames = true 
  enable_dns_support = true
  tags = merge (local.common_tags,{
    Name = "${local.name_prefix}-vpc"
  }) 
}


# public layer 

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = local.public_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = merge( local.common_tags,{
    Name = "${local.name_prefix}-public-subnet"
    # to recheck when starting kubernetes deployment 
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${local.name_prefix}" = "shared"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-igw"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# private layer : i wont't need a route table since its only for the rds 

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = local.private_subnet_cidr
  availability_zone = var.availability_zone
  tags = merge(local.common_tags,{
    Name = "${local.name_prefix}-private-subnet"
  })
}

# second private subnet for RDS subnet group AZ coverage
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnet_cidr_2
  availability_zone = var.availability_zone_2
  tags = merge(local.common_tags,{
    Name = "${local.name_prefix}-private-subnet-b"
  })
}
