resource "aws_instance" "ec2-instance" {
  ami                         = var.instance-info.ami
  instance_type               = var.instance-info.size
  associate_public_ip_address = var.instance-info.associate_pub_ip
  key_name                    = var.instance-info.key_name
  subnet_id                   = var.instance-info.subnet_id
  vpc_security_group_ids      = [var.instance-info.security_group_id]
  user_data                   = var.instance-info.user_data ? file(var.instance-info.user_data_script) : ""
  tags = {
    Name = var.instance-info.name
  }
}