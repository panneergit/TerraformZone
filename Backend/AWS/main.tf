# fetch ubuntu ami
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

data "aws_key_pair" "keypair" {
  key_name = var.key_name
}

data "aws_security_group" "security_group" {
  name = var.security_group_name
}

data "aws_vpc" "defaultvpc" {
  default = true
}

data "aws_subnet" "awssubnet" {
  vpc_id            = data.aws_vpc.defaultvpc.id
  availability_zone = var.az
}

resource "aws_instance" "web_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_size
  subnet_id                   = data.aws_subnet.awssubnet.id
  vpc_security_group_ids      = [data.aws_security_group.security_group.id]
  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.keypair.key_name
  user_data                   = file("install.sh")
  tags = {
    Name    = "Web-Server",
    Feature = "Backend"
  }

  depends_on = [
    data.aws_ami.ubuntu, data.aws_key_pair.keypair,
    data.aws_security_group.security_group,
    data.aws_subnet.awssubnet,
    data.aws_vpc.defaultvpc
  ]
}
