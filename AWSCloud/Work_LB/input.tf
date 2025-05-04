variable "region" {
  type    = string
  default = "us-east-1"
}

variable "network" {
  type = object({
    name = string
    cidr = string
    private-subnet = list(object({
      name = string
      cidr = string
      az   = string
    }))
    public-subnet = list(object({
      name = string
      cidr = string
      az   = string
    }))
  })
  description = "This AWS Network"
}

variable "websg" {
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
  description = "This is ntier web security group"
}

variable "dbsg" {
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
  description = "This is ntier db security group"

}
