output "instance-ip" {
  value = aws_instance.ec2-instance.public_ip
}

output "instance-dns" {
  value = aws_instance.ec2-instance.public_dns
}

