variable "vpc-info" {
  type = object({
    name = string
    cidr = string
  })
  description = "This is VPC Network"
  default = {
    name = "This is VPC"
    cidr = "192.168.0.0/16"
  }
}

variable "private-subnet" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  description = "This is Private Subnet"
}

variable "public-subnet" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  description = "This is Public Subnet"

}
