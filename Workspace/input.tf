variable "vpc-info" {
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
}