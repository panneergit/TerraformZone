# Assign values to respective variables

resgroupname = {
  name     = "demo-resource-group"
  location = "West Europe"
}

virtual-network = {
  name          = "demo-virtual-network"
  address_space = ["10.11.0.0/16"]
}

# Subnets

subnets = [
  {
    name             = "app-subnet"
    address_prefixes = "10.11.0.0/24"
  },
  {
    name             = "db-subnet"
    address_prefixes = "10.11.1.0/24"
  },
  {
    name             = "web-subnet"
    address_prefixes = "10.11.2.0/24"
  }
]
