terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "6c25c924-7f52-4a3e-9784-24134c8c93c1"
}