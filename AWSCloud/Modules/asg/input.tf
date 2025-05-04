variable "lunch_template" {
  type = object({
    name          = string
    image_id      = string
    instance_type = string
    key_name      = string
    user_data         = bool
    user_data_script  = string
    vpc_security_group_ids = list(string)
  })
}

variable "autoscaling_group" {
    type = object({
      desired_capacity = number
      max_size         = number
      min_size         = number
      subnets          = list(string)
      lb_target_group_arns = string
    })

}