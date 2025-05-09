variable "aws_eks_cluster_info" {
  type = object({
    name                = string
    version             = string
    eks_role_arn        = string
    self_managed_addons = bool
    access_config = object({
      authentication_mode = string
    })
    vpc_config = object({
      public_access  = bool
      private_access = bool
      public_cidrs   = list(string)
      security_group_ids   = list(string)
      subnet_ids     = list(string)
    })

  })
  description = "This is EKS Clauter creation information"
}

variable "aws_eks_node_group_info" {
  type = object({
    name           = string
    node_role_arn  = string
    subnet_ids     = list(string)
    ami_type       = string
    instance_types = list(string)
    capacity_type  = string

    scaling_config = object({
      desired_size = number
      min_size     = number
      max_size     = number
    })

    update_config = object({
      max_unavailable = number
    })

  })
  description = "This is EKS Clauter - Node Group and Scaling information"
}
