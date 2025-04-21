resource "aws_security_group" "ntier-sg" {
  name        = var.ntiersg.name
  description = var.ntiersg.description
  vpc_id      = aws_vpc.ntier-vpc.id
  depends_on  = [aws_vpc.ntier-vpc]
  tags = {
    Name = var.ntiersg.name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ntier-sg-ingress" {
  count             = length(var.ntiersg.ingress_rules)
  security_group_id = aws_security_group.ntier-sg.id
  cidr_ipv4         = var.ntiersg.ingress_rules[count.index].cidr
  from_port         = var.ntiersg.ingress_rules[count.index].port
  to_port           = var.ntiersg.ingress_rules[count.index].port
  ip_protocol       = var.ntiersg.ingress_rules[count.index].protocol
  description       = var.ntiersg.ingress_rules[count.index].description
  depends_on        = [aws_security_group.ntier-sg]
}

resource "aws_vpc_security_group_egress_rule" "ntier-sg-all-egress" {
  count             = var.ntiersg.allow_all_egress ? 1 : 0
  security_group_id = aws_security_group.ntier-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  depends_on        = [aws_security_group.ntier-sg]
}