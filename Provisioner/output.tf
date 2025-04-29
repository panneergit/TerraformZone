output "ssh" {
  value = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.web_instance.public_ip}"
}

output "Preschool-URL" {
  value = "http://${aws_instance.web_instance.public_ip}/preschool"
}

output "Healet-URL" {
  value = "http://${aws_instance.web_instance.public_ip}/healet"
}
