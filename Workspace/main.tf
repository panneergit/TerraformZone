module "vpc" {
  source = "github.com/panneergit/TerraformZone//AWSCloud/Modules/vpc"
  vpc-info = {
    name = var.vpc-info.name
    cidr = var.vpc-info.cidr
  }

  private-subnet = var.vpc-info.private-subnet
  public-subnet  = var.vpc-info.public-subnet
}