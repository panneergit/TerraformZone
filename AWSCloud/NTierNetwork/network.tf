resource "aws_vpc" "ntier-vpc" {
  cidr_block = var.ntiervpc.cidr
  tags = {
    Name = var.ntiervpc.name
  }
}

resource "aws_subnet" "ntier-pvr-sb" {
  count             = length(var.ntierpvrsb)
  vpc_id            = aws_vpc.ntier-vpc.id
  cidr_block        = var.ntierpvrsb[count.index].cidr
  availability_zone = var.ntierpvrsb[count.index].az
  depends_on        = [aws_vpc.ntier-vpc]
  tags = {
    Name = var.ntierpvrsb[count.index].name
  }
}

resource "aws_subnet" "ntier-pub-sb" {
  count             = length(var.ntierpubsb)
  vpc_id            = aws_vpc.ntier-vpc.id
  cidr_block        = var.ntierpubsb[count.index].cidr
  availability_zone = var.ntierpubsb[count.index].az
  depends_on        = [aws_vpc.ntier-vpc]
  tags = {
    Name = var.ntierpubsb[count.index].name
  }
}

resource "aws_internet_gateway" "ntier-ig" {
  vpc_id     = aws_vpc.ntier-vpc.id
  depends_on = [aws_vpc.ntier-vpc]
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "ntier-pub-rt" {
  vpc_id = aws_vpc.ntier-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ntier-ig.id
  }
  depends_on = [aws_vpc.ntier-vpc, aws_internet_gateway.ntier-ig]
  tags = {
    Name = "This is public route table"
  }
}

resource "aws_route_table_association" "ntier-pub-rt-associate" {
  count          = length(var.ntierpubsb)
  subnet_id      = aws_subnet.ntier-pub-sb[count.index].id
  route_table_id = aws_route_table.ntier-pub-rt.id
  depends_on     = [aws_subnet.ntier-pub-sb, aws_route_table.ntier-pub-rt]
}