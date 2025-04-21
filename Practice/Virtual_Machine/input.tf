# Variable Defination

# Resource Group Variables
variable "resgroupname" {
  type = object({
    name     = string
    location = string
  })
  description = "Default Resource Group"
  default = {
    name     = "default-rsg"
    location = "Central India"
  }
}

# Virtual Network Variables
variable "virtual-network" {
  type = object({
    name          = string
    address_space = list(string)
  })
  description = "Default Virtual Network"
  default = {
    name          = "default virtual network"
    address_space = ["192.168.0.0/16"]
  }
}

# Subnet Variable
variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = string
  }))
  description = "Subnet name and CICDR Ranges"
  default = [{
    name             = "default-subnet"
    address_prefixes = "192.168.0.0/24"
  }]
}

#Public IP
variable "public-ip" {
  type = object({
    name = string
    allocation_method = string
  })
  description = "Public IP"
  default = {
    name = "public-ip"
    allocation_method = "Dynamic"
  }
}