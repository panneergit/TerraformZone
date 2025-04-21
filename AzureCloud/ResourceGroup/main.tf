resource "azurerm_resource_group" "demo-resource-grp" {
  name     = "demorsgrp"
  location = "centralindia"
  tags = {
    Env       = "DEV"
    CreatedBy = "Terraform"
  }
}