data "aws_vpc" "vpc" {
  default = true
  filter {
    name   = "tag:Name"
    values = ["Default VPC"]
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  depends_on = [data.aws_vpc.vpc]
}

data "aws_security_groups" "security" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  depends_on = [data.aws_vpc.vpc]
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}