terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.97.0"
    }
  }
}

provider "aws" {

  region = "us-east-1"

  default_tags {
    tags = {
      CreatedBy   = "Terraform"
      Environment = terraform.workspace
    }
  }
}