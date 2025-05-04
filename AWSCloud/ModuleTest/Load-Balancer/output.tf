output "preschool_url" {
  value = "http://${module.nw_load_balancer.awslb_dns}/preschool"
}