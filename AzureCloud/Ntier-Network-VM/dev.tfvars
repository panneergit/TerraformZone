aznetworkz = {
  name          = "Ntier-Primary-Network"
  address_space = ["10.10.0.0/16"]
}

azsubnetnames = ["web-sbn", "app-sbn", "db-sbn"]

azsubnetaddprefix = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24"]

nwtsecurityrules = [{
  name                       = "openSSH"
  description                = "This is Open for port 22"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  access                     = "Allow"
  priority                   = 1000
  },
  {
    name                       = "openHTTP"
    description                = "This is Open for port 80"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = 1010
  }
]

web_vm_info = {
  name        = "webservervmx"
  username    = "panneer"
  publick_key = "~/id_rsa.pub"
  size        = "Standard_B1s"
  publisher   = "canonical"
  offer       = "0001-com-ubuntu-server-jammy"
  sku         = "22_04-lts-gen2"
  version     = "latest"
}