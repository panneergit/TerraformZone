module "vpc" {
  source = "../Modules/vpc"
  vpc-info = {
    name = "Ntier-primary"
    cidr = "10.10.0.0/16"
  }

  private-subnet = [{
    name = "db-1"
    cidr = "10.10.0.0/24"
    az   = "us-east-1a"
    }, {
    name = "db-2"
    cidr = "10.10.1.0/24"
    az   = "us-east-1b"
  }]

  public-subnet = [{
    name = "Web-1"
    cidr = "10.10.2.0/24"
    az   = "us-east-1a"
    }, {
    name = "web-2"
    cidr = "10.10.3.0/24"
    az   = "us-east-1b"
  }]
}

module "web-security-group" {
  source = "../Modules/securitygroup"
  securitygroup-info = {
    name             = "Web Security Group"
    description      = "This is web security group"
    vpc_id           = module.vpc.vpcid
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
}

module "db-security-group" {
  source = "../Modules/securitygroup"
  securitygroup-info = {
    name             = "DB Security Group"
    description      = "This is db security group"
    vpc_id           = module.vpc.vpcid
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
}

module "web-instance" {
  source = "../Modules/ec2"
  count  = length(var.web-instances)
  instance-info = {
    name              = var.web-instances[count.index].name
    ami               = var.web-instances[count.index].ami
    size              = var.web-instances[count.index].size
    key_name          = var.web-instances[count.index].key_name
    associate_pub_ip  = var.web-instances[count.index].associate_pub_ip
    user_data         = var.web-instances[count.index].user_data
    user_data_script  = var.web-instances[count.index].user_data_script
    subnet_id         = module.vpc.public-subnet[0]
    security_group_id = module.web-security-group.security-group-id
  }
}

module "db-instance" {
  source = "../Modules/ec2"
  count  = length(var.db-instances)
  instance-info = {
    name              = var.db-instances[count.index].name
    ami               = var.db-instances[count.index].ami
    size              = var.db-instances[count.index].size
    key_name          = var.db-instances[count.index].key_name
    associate_pub_ip  = var.db-instances[count.index].associate_pub_ip
    user_data         = var.db-instances[count.index].user_data
    user_data_script  = var.db-instances[count.index].user_data_script
    subnet_id         = module.vpc.public-subnet[0]
    security_group_id = module.db-security-group.security-group-id
  }
}