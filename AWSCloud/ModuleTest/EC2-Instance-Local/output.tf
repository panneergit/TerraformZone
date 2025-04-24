output "vpcid" {
  value = module.vpc.vpcid
}

output "private-subnet" {
  value = module.vpc.private-subnet
}

output "public-subnet" {
  value = module.vpc.public-subnet
}

output "web-security-group-id" {
  value = module.web-security-group.security-group-id
}

output "db-security-group-id" {
  value = module.db-security-group.security-group-id
}

output "web-instance-ip" {
  value = module.web-instance.*.instance-ip
}

output "web-instance-dns" {
  value = module.web-instance.*.instance-dns
}

output "web-preschoolurl" {
  value = [
    for instance in module.web-instance : "http://${instance.instance-ip}/preschool"
  ]
}
