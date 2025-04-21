variable "aznetworkz" {
  type = object({
    name          = string
    address_space = list(string)
  })
  description = "This is N Tier Virtual Network"
  default = {
    name          = "aznetwork"
    address_space = ["192.168.0.0/16"]
  }
}

variable "azsubnetnames" {
  type        = list(string)
  description = "This is N Tier Subnets - Names"
  default     = ["web-sb"]

}

variable "azsubnetaddprefix" {
  type        = list(string)
  description = "This is N Tier Subnets - Address Prefix"
  default     = ["192.168.0.0/24"]
}

variable "nwtsecurityrules" {
  type = list(object({
    name                       = string
    description                = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    access                     = string
    priority                   = number
  }))
  description = "This is security group rules"
  default = [{
    name                       = "openSSH"
    description                = "This is Open for port 22"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority = 1000 }
  ]
}

variable "web_vm_info" {
  type = object({
    name        = string
    username    = string
    publick_key = string
    size        = string
    publisher   = string
    offer       = string
    sku         = string
    version     = string
  })
  description = "This is WEB VM info"
  default = {
    name        = "webservervm"
    username    = "Dell"
    publick_key = "~/id_rsa.pub"
    size        = "Standard_B1s"
    publisher   = "canonical"
    offer       = "0001-com-ubuntu-server-jammy"
    sku         = "22_04-lts-gen2"
    version     = "latest"
  }
}