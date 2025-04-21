resource "azurerm_resource_group" "demo-res-grp" {
  name     = var.resgrp.name
  location = var.resgrp.location
  tags     = var.tags
}

resource "azurerm_storage_account" "demostrgacct" {
  name                     = var.stagacct.name
  resource_group_name      = azurerm_resource_group.demo-res-grp.name
  location                 = azurerm_resource_group.demo-res-grp.location
  account_tier             = var.stagacct.account_tier
  account_replication_type = var.stagacct.account_replication_type
  tags                     = azurerm_resource_group.demo-res-grp.tags

  depends_on = [azurerm_resource_group.demo-res-grp]
}


# terraform import <RESOURCE_TYPE>.<RESOURCE NAME> "RESOURCE ID"
# terraform state show <RESOURCE_TYPE>.<RESOURCE NAME>

# resource "azurerm_resource_group" "NetworkWatcherRG" {
#   id         = "/subscriptions/6c25c924-7f52-4a3e-9784-24134c8c93c1/resourceGroups/NetworkWatcherRG"
#   location   = "eastus"
#   managed_by = null
#   name       = "NetworkWatcherRG"
#   tags       = {}
# }