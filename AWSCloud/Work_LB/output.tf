output "url" {
  value = "http://${aws_lb.preschool-lb.dns_name}/preschool"
}