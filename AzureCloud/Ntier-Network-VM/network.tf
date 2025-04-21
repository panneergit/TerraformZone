resource "azurerm_virtual_network" "ntiernwt" {
  name                = var.aznetworkz.name
  resource_group_name = azurerm_resource_group.ntiernwtgrp.name
  location            = azurerm_resource_group.ntiernwtgrp.location
  address_space       = var.aznetworkz.address_space
  tags                = azurerm_resource_group.ntiernwtgrp.tags
  depends_on          = [azurerm_resource_group.ntiernwtgrp]
}

resource "azurerm_subnet" "ntiernwtsb" {
  count                = length(var.azsubnetnames)
  name                 = var.azsubnetnames[count.index]
  resource_group_name  = azurerm_resource_group.ntiernwtgrp.name
  virtual_network_name = azurerm_virtual_network.ntiernwt.name
  address_prefixes     = [var.azsubnetaddprefix[count.index]]
  depends_on           = [azurerm_resource_group.ntiernwtgrp, azurerm_virtual_network.ntiernwt]
}