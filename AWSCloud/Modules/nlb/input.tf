variable "load_balancer" {
    type = object({
        name = string
        lb_type = string
        internal = bool
        subnets = list(string)
        security_groups = list(string)
    })
}

variable "target_group" {
    type = object({
      name = string
      vpc_id = string
    })
}
