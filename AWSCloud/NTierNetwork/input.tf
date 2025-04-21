variable "ntiervpc" {
  type = object({
    name = string
    cidr = string
  })
  description = "This is Ntier VPC Network"
  default = {
    name = "Ntier VPC"
    cidr = "192.168.0.0/16"
  }
}

variable "ntierpvrsb" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  description = "This is Private Subnet"
}

variable "ntierpubsb" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  description = "This is Public Subnet"

}

variable "ntiersg" {
  type = object({
    name        = string
    description = string
    ingress_rules = list(object({
      cidr        = string
      port        = string
      protocol    = string
      description = string
    }))
    eggress_rules = list(object({
      cidr        = string
      port        = string
      protocol    = string
      description = string
    }))
    allow_all_egress = bool
  })
  description = "This is ntier security group"
}

variable "webinsc" {
  type = object({
    name              = string
    size              = string
    ami               = string
    subnet_id         = string
    security_group_id = string
    key_name          = string
  })
}