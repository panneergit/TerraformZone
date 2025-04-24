resource "aws_security_group" "this" {
  name        = var.securitygroup-info.name
  description = var.securitygroup-info.description
  vpc_id      = var.securitygroup-info.vpc_id
  tags = {
    Name = var.securitygroup-info.name
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  count             = length(var.securitygroup-info.ingress_rules)
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = var.securitygroup-info.ingress_rules[count.index].cidr
  from_port         = var.securitygroup-info.ingress_rules[count.index].port
  to_port           = var.securitygroup-info.ingress_rules[count.index].port
  ip_protocol       = var.securitygroup-info.ingress_rules[count.index].protocol
  description       = var.securitygroup-info.ingress_rules[count.index].description
  depends_on        = [aws_security_group.this]
}

resource "aws_vpc_security_group_egress_rule" "this" {
  count = length(var.securitygroup-info.eggress_rules)
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = var.securitygroup-info.eggress_rules[count.index].cidr
  from_port         = var.securitygroup-info.eggress_rules[count.index].port
  to_port           = var.securitygroup-info.eggress_rules[count.index].port
  ip_protocol       = var.securitygroup-info.eggress_rules[count.index].protocol
  description       = var.securitygroup-info.eggress_rules[count.index].description
  depends_on        = [aws_security_group.this]
}

resource "aws_vpc_security_group_egress_rule" "all-egress" {
  count             = var.securitygroup-info.allow_all_egress ? 1 : 0
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  depends_on        = [aws_security_group.this]
}