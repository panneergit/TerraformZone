resource "aws_lb" "preschool-lb" {
  load_balancer_type = "network"
  name               = "preschool-lb"
  internal           = false
  subnets            = module.vpc.public-subnet
  security_groups    = [module.web-security-group.security-group-id]
}

resource "aws_lb_target_group" "preschool-tg" {
  name     = "preschool-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = module.vpc.vpcid
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.preschool-lb.arn
  port              = 80
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.preschool-tg.arn
  }
}
