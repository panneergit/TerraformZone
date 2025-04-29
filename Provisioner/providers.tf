terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}

provider "aws" {
  region = var.primary_region
  default_tags {
    tags = {
      CreatedBy   = "Terraform"
      Environment = "Dev"
    }
  }
}