resource "azurerm_public_ip" "ntiernwtpubip" {
  name                = "ntiernwtpubip"
  resource_group_name = azurerm_resource_group.ntiernwtgrp.name
  location            = azurerm_resource_group.ntiernwtgrp.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = azurerm_resource_group.ntiernwtgrp.tags
  depends_on          = [azurerm_resource_group.ntiernwtgrp]
}

resource "azurerm_network_security_group" "ntiernwtsgrp" {
  name                = "ntiernwtsgrp"
  resource_group_name = azurerm_resource_group.ntiernwtgrp.name
  location            = azurerm_resource_group.ntiernwtgrp.location
  tags                = azurerm_resource_group.ntiernwtgrp.tags
  depends_on          = [azurerm_resource_group.ntiernwtgrp]
}

resource "azurerm_network_security_rule" "ntiernwtsgrprule" {
  count                       = length(var.nwtsecurityrules)
  name                        = var.nwtsecurityrules[count.index].name
  resource_group_name         = azurerm_resource_group.ntiernwtgrp.name
  network_security_group_name = azurerm_network_security_group.ntiernwtsgrp.name
  description                 = var.nwtsecurityrules[count.index].description
  protocol                    = var.nwtsecurityrules[count.index].protocol
  source_port_range           = var.nwtsecurityrules[count.index].source_port_range
  destination_port_range      = var.nwtsecurityrules[count.index].destination_port_range
  source_address_prefix       = var.nwtsecurityrules[count.index].source_address_prefix
  destination_address_prefix  = var.nwtsecurityrules[count.index].destination_address_prefix
  access                      = var.nwtsecurityrules[count.index].access
  priority                    = var.nwtsecurityrules[count.index].priority
  direction                   = "Inbound"
  depends_on                  = [azurerm_resource_group.ntiernwtgrp, azurerm_network_security_group.ntiernwtsgrp]
}

resource "azurerm_network_interface" "ntiernic" {
  name                = "ntiernic"
  resource_group_name = azurerm_resource_group.ntiernwtgrp.name
  location            = azurerm_resource_group.ntiernwtgrp.location
  ip_configuration {
    name                          = "nicipconfig"
    subnet_id                     = azurerm_subnet.ntiernwtsb[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ntiernwtpubip.id
  }
  depends_on = [azurerm_resource_group.ntiernwtgrp, azurerm_subnet.ntiernwtsb, azurerm_public_ip.ntiernwtpubip]
}

resource "azurerm_network_interface_security_group_association" "ntierincscgass" {
  network_interface_id      = azurerm_network_interface.ntiernic.id
  network_security_group_id = azurerm_network_security_group.ntiernwtsgrp.id

  depends_on = [azurerm_network_interface.ntiernic, azurerm_network_security_group.ntiernwtsgrp]
}

resource "azurerm_linux_virtual_machine" "ntinerwebvm" {
  name                  = var.web_vm_info.name
  resource_group_name   = azurerm_resource_group.ntiernwtgrp.name
  location              = azurerm_resource_group.ntiernwtgrp.location
  network_interface_ids = [azurerm_network_interface.ntiernic.id]
  admin_username        = var.web_vm_info.username
  admin_ssh_key {
    username   = var.web_vm_info.username
    public_key = file(var.web_vm_info.publick_key)
  }
  size = var.web_vm_info.size
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  source_image_reference {
    publisher = var.web_vm_info.publisher
    offer     = var.web_vm_info.offer
    sku       = var.web_vm_info.sku
    version   = var.web_vm_info.version
  }
  custom_data = filebase64("install.sh")
  tags        = azurerm_resource_group.ntiernwtgrp.tags
}