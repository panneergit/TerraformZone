ntiervpc = {
  name = "Ntier VPC"
  cidr = "10.0.0.0/16"
}

ntierpvrsb = [
  {
    name = "DB Subnet-1"
    cidr = "10.0.2.0/24"
    az   = "us-east-1a"
  },
  {
    name = "DB Subnet-2"
    cidr = "10.0.3.0/24"
    az   = "us-east-1a"
  }
]

ntierpubsb = [
  {
    name = "Web Subnet-1"
    cidr = "10.0.0.0/24"
    az   = "us-east-1a"
  },
  {
    name = "Web Subnet-2"
    cidr = "10.0.1.0/24"
    az   = "us-east-1a"
  }
]

ntiersg = {
  name        = "Ntier Security Group"
  description = "This is Ntier security group"
  ingress_rules = [{
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
  eggress_rules    = []
  allow_all_egress = true
}

webinsc = {
  name              = "Web-Server"
  size              = "t2.micro"
  ami               = "ami-084568db4383264d4"
  key_name          = "id_rsa"
  subnet_id         = ""
  security_group_id = ""
}