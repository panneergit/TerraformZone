resource "aws_instance" "web-server" {
  ami                         = var.webinsc.ami
  instance_type               = var.webinsc.size
  associate_public_ip_address = true
  key_name                    = var.webinsc.key_name
  subnet_id                   = aws_subnet.ntier-pub-sb[0].id
  vpc_security_group_ids      = [aws_security_group.ntier-sg.id]
  user_data                   = file("install.sh")
  tags = {
    Name = var.webinsc.name
  }
  depends_on = [aws_subnet.ntier-pub-sb, aws_security_group.ntier-sg]

}