resource "aws_lb" "load_balancer" {  
  name               = var.load_balancer.name
  load_balancer_type = var.load_balancer.lb_type
  internal           = var.load_balancer.internal
  subnets            = var.load_balancer.subnets
  security_groups    = var.load_balancer.security_groups
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = var.target_group.name
  port     = local.http
  protocol = local.TCP
  vpc_id   = var.target_group.vpc_id
}

resource "aws_lb_listener" "lb_listeners" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = local.http
  protocol          = local.TCP
  default_action {
    type             = local.forward
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}
