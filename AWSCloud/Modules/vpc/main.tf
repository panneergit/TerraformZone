resource "aws_vpc" "network-vpc" {
  cidr_block = var.vpc-info.cidr
  tags = {
    Name = var.vpc-info.name
  }
}

resource "aws_subnet" "private-subnet" {
  count             = length(var.private-subnet)
  vpc_id            = aws_vpc.network-vpc.id
  cidr_block        = var.private-subnet[count.index].cidr
  availability_zone = var.private-subnet[count.index].az
  depends_on        = [aws_vpc.network-vpc]
  tags = {
    Name = var.private-subnet[count.index].name
  }
}

resource "aws_subnet" "public-subnet" {
  count             = length(var.public-subnet)
  vpc_id            = aws_vpc.network-vpc.id
  cidr_block        = var.public-subnet[count.index].cidr
  availability_zone = var.public-subnet[count.index].az
  depends_on        = [aws_vpc.network-vpc]
  tags = {
    Name = var.public-subnet[count.index].name
  }
}

resource "aws_internet_gateway" "internet-gatway" {
  vpc_id     = aws_vpc.network-vpc.id
  depends_on = [aws_vpc.network-vpc]
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.network-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gatway.id
  }
  depends_on = [aws_vpc.network-vpc, aws_internet_gateway.internet-gatway]
  tags = {
    Name = "This is public route table"
  }
}

resource "aws_route_table_association" "public-route-table-associate" {
  count          = length(var.public-subnet)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-route-table.id
  depends_on     = [aws_subnet.public-subnet, aws_route_table.public-route-table]
}
