resource "aws_launch_template" "lunch_template" {
  name          = var.lunch_template.name
  image_id      = var.lunch_template.image_id
  instance_type = var.lunch_template.instance_type
  key_name      = var.lunch_template.key_name
  user_data     = var.lunch_template.user_data ? filebase64(var.lunch_template.user_data_script) : ""
  vpc_security_group_ids = var.lunch_template.vpc_security_group_ids
  tags = {
    Name = var.lunch_template.name
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
  launch_template {
    id      = aws_launch_template.lunch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = var.autoscaling_group.subnets
  target_group_arns   = [var.autoscaling_group.lb_target_group_arns]
}
