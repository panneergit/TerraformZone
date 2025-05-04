output "awslb_dns" {
  value = aws_lb.load_balancer.dns_name
}

output "target_group_arns" {
  value = aws_lb_target_group.lb_target_group.arn
}