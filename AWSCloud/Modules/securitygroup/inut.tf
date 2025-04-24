variable "securitygroup-info" {
  type = object({
    name        = string
    description = string
    vpc_id      = string
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
