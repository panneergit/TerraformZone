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

# launch template
resource "aws_launch_template" "preschool-lt" {
  name          = "preschool"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "id_rsa"
  vpc_security_group_ids = [
    module.web-security-group.security-group-id
  ]
  tags = {
    Name = "preschool"
  }
  user_data = filebase64("install.sh")

  depends_on = [
    module.vpc,
    module.web-security-group,
    data.aws_ami.ubuntu
  ]
}

#Auto scaling group
resource "aws_autoscaling_group" "preschool-asg" {
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
  launch_template {
    id      = aws_launch_template.preschool-lt.id
    version = "$Latest"
  }
  vpc_zone_identifier = module.vpc.public-subnet
  target_group_arns   = [aws_lb_target_group.preschool-tg.arn]
}