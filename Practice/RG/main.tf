# Resource Group
resource "azurerm_resource_group" "demo-resource-grp" {
  name     = var.resgroupname.name
  location = var.resgroupname.location
  tags = {
    environment = "dev"
    createdBy   = "Terraform"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "demo-virtuak-network" {
  name                = var.virtual-network.name
  resource_group_name = azurerm_resource_group.demo-resource-grp.name
  location            = azurerm_resource_group.demo-resource-grp.location
  address_space       = var.virtual-network.address_space
  depends_on          = [azurerm_resource_group.demo-resource-grp]
  tags = {
    environment = "dev"
    createdBy   = "Terraform"
  }
}

# Virtual Subnets
resource "azurerm_subnet" "demo-subnets" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  resource_group_name  = azurerm_resource_group.demo-resource-grp.name
  virtual_network_name = azurerm_virtual_network.demo-virtuak-network.name
  address_prefixes     = [var.subnets[count.index].address_prefixes]
  depends_on           = [azurerm_resource_group.demo-resource-grp, azurerm_virtual_network.demo-virtuak-network]
}