resource "azurerm_resource_group" "ntiernwtgrp" {
  name     = "ntiernwtvm"
  location = "centralindia"
  tags = {
    Env       = "DEV"
    CreatedBy = "Terraform"
  }
}

