resource "azurerm_resource_group" "azrespgrp" {
  name     = "azrespgrp"
  location = "centralindia"
  tags = {
    Evn       = "Dev"
    CreatedBy = "Terraform"
  }
}

resource "azurerm_virtual_network" "aznetwork" {
  name                = var.aznetworkz.name
  resource_group_name = azurerm_resource_group.azrespgrp.name
  location            = azurerm_resource_group.azrespgrp.location
  address_space       = var.aznetworkz.address_space
  depends_on          = [azurerm_resource_group.azrespgrp]
}

resource "azurerm_subnet" "aznetsubnet" {
  count                = length(var.azsubnetnames)
  name                 = var.azsubnetnames[count.index]
  resource_group_name  = azurerm_resource_group.azrespgrp.name
  virtual_network_name = azurerm_virtual_network.aznetwork.name
  address_prefixes     = [var.subvnetaddprx[count.index]]
  depends_on           = [azurerm_resource_group.azrespgrp, azurerm_virtual_network.aznetwork]
}