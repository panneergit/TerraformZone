terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.96.0"
    }
  }
  backend "s3" {
    region         = "us-east-1"
    bucket         = "myterraformbackendbkt"
    key            = "terraform/backend/state.lock"
    dynamodb_table = "terraformstate_locktable"
    //use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      CreatedBy   = "Terraform"
      Environment = "Dev"
    }
  }
}