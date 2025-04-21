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

# Public IP

resource "azurerm_public_ip" "demo-public-ip" {
  name = var.public-ip.naem
  resource_group_name = azurerm_resource_group.demo-resource-grp.name
  location = azurerm_resource_group.demo-resource-grp.location
  allocation_method = var.public-ip.allocation_method
  depends_on          = [azurerm_resource_group.demo-resource-grp]
  tags = {
    environment = "dev"
    createdBy   = "Terraform"
  }
}

# Network Security Group
resource "azurerm_network_security_group" "demo-network-security-grp" {
  name = sdsd
  resource_group_name = azurerm_resource_group.demo-resource-grp.name
  location = azurerm_resource_group.demo-resource-grp.location
depends_on          = [azurerm_resource_group.demo-resource-grp]
  tags = {
    environment = "dev"
    createdBy   = "Terraform"
  }
}

# Network Security Rules
resource "azurerm_network_security_rule" "demo-network-security-rules" {
  name = address_space
  resource_group_name = sdsd
  network_security_group_name = sdfsd
  description = sdsd
  protocol = abs(asdfdsf)
  source_port_range = sdfsd
  destination_port_range = sdsd
  source_address_prefix = sdsd
  destination_address_prefix = destination_address_prefix
  access = sdsd
  priority = destination_address_prefix
  direction = sdsd
}