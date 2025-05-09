variable "eks_ima_role" {
  type        = string
  description = "This is IAM role for EKS Cluster"
  default     = "my-eks-cluster-role"
}

variable "eks_ec2_iam_role" {
  type        = string
  description = "This is IAM role for EC2 resopurce access role from EKS"
  default     = "my_eks_ec2_ng"
}

variable "eks_info" {
  type = object({
    name           = string
    version        = string
    addons         = bool
    auth_mode      = string
    public_access  = bool
    private_access = bool
    public_cidrs   = list(string)
    subnet_ids     = list(string)
  })

}

variable "eks_ng_info" {
  type = object({
    name           = string
    ami_type       = string
    capacity_type  = string
    instance_types = list(string)
    subnet_ids     = list(string)

    desired_size = number
    min_size     = number
    max_size     = number

    max_unavailable = number
  })
}