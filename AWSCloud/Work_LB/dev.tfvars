network = {
  name = "Ntier VPC"
  cidr = "10.10.0.0/16"

  private-subnet = [{
    name = "db-1"
    cidr = "10.10.0.0/24"
    az   = "us-east-1a"
    },
    {
      name = "db-2"
      cidr = "10.10.1.0/24"
      az   = "us-east-1b"
  }]

  public-subnet = [{
    name = "web-1"
    cidr = "10.10.2.0/24"
    az   = "us-east-1a"
    },
    {
      name = "web-2"
      cidr = "10.10.3.0/24"
      az   = "us-east-1b"
  }]
}

websg = {
  name             = "Web Security Group"
  description      = "This is web security group"
  allow_all_egress = true
  ingress_rules = [
    {
      cidr        = "0.0.0.0/0"
      port        = "22"
      protocol    = "tcp"
      description = "open ssh"
    },
    {
      cidr        = "0.0.0.0/0"
      port        = "80"
      protocol    = "tcp"
      description = "open http"
    },
    {
      cidr        = "0.0.0.0/0"
      port        = "443"
      protocol    = "tcp"
      description = "open https"
  }]
  eggress_rules = []
}

dbsg = {
  name             = "DB Security Group"
  description      = "This is db security group"
  allow_all_egress = true
  ingress_rules = [
    {
      cidr        = "0.0.0.0/0"
      port        = "3306"
      protocol    = "tcp"
      description = "open mysql"
  }]
  eggress_rules = []
}
