module "vpc" {
  source = "github.com/panneergit/TerraformZone//AWSCloud/Modules/vpc"
  vpc-info = {
    name = var.network.name
    cidr = var.network.cidr
  }
  private-subnet = var.network.private-subnet
  public-subnet  = var.network.public-subnet
}

module "web-security-group" {
  source = "github.com/panneergit/TerraformZone//AWSCloud/Modules/securitygroup"

  securitygroup-info = {
    name             = var.websg.name
    description      = var.websg.description
    vpc_id           = module.vpc.vpcid
    allow_all_egress = true
    ingress_rules    = var.websg.ingress_rules
    eggress_rules    = var.websg.eggress_rules
  }
  depends_on = [module.vpc]
}

module "db-security-group" {
  source = "github.com/panneergit/TerraformZone//AWSCloud/Modules/securitygroup"
  securitygroup-info = {
    name             = var.dbsg.name
    description      = var.dbsg.description
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
  depends_on = [module.vpc]
}

