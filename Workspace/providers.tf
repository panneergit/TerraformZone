terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }
  backend "s3" {
    region         = "us-east-1"
    bucket         = "myterrabackendbkt"
    key            = "terraform/workspacedemo"
    dynamodb_table = "terraformstate_locktable"
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
