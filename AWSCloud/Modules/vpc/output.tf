output "vpcid" {
  value = aws_vpc.network-vpc.id
}

output "private-subnet" {
  value = aws_subnet.private-subnet.*.id
}

output "public-subnet" {
  value = aws_subnet.public-subnet.*.id
}