variable "aznetworkz" {
  type = object({
    name          = string
    address_space = list(string)
  })
  description = "This is Virtual Network"
  default = {
    name          = "aznetwork"
    address_space = ["192.168.0.0/16"]
  }
}

variable "azsubnetnames" {
  type        = list(string)
  description = "This is nertwork subnect"
  default     = ["az-subnet1", "az-subnet2"]

}

variable "subvnetaddprx" {
  type        = list(string)
  description = "This subnet's address prefix"
  default     = ["192.168.0.0/24", "192.168.1.0/24"]
}