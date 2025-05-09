data "aws_iam_role" "eks_role" {
  name = var.eks_ima_role
}

# Get IAM Role for EC2 Machine
data "aws_iam_role" "eks_ec2_role" {
  name = var.eks_ec2_iam_role
}

// Get Default VPC
data "aws_vpc" "defaultvpc" {
  default = true
}

# Get Default Subnets
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.defaultvpc.id]
  }
  depends_on = [data.aws_vpc.defaultvpc]
}

# Get Security Group
data "aws_security_groups" "security" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.defaultvpc.id]
  }
  depends_on = [data.aws_vpc.defaultvpc]
}

module "aws_eks_cluster" {
  source = "github.com/panneergit/TerraformZone//AWSCloud/Modules/eks"

  aws_eks_cluster_info = {
    name                = var.eks_info.name
    version             = var.eks_info.version
    eks_role_arn        = data.aws_iam_role.eks_role.arn
    self_managed_addons = var.eks_info.addons
    access_config = {
      authentication_mode = var.eks_info.auth_mode
    }
    vpc_config = {
      public_access      = var.eks_info.public_access
      private_access     = var.eks_info.private_access
      public_cidrs       = var.eks_info.public_cidrs
      security_group_ids = data.aws_security_groups.security.ids
      subnet_ids         = var.eks_info.subnet_ids
    }
  }

  aws_eks_node_group_info = {
    name           = var.eks_ng_info.name
    node_role_arn  = data.aws_iam_role.eks_ec2_role.arn
    ami_type       = var.eks_ng_info.ami_type
    capacity_type  = var.eks_ng_info.capacity_type
    instance_types = var.eks_ng_info.instance_types
    subnet_ids     = var.eks_ng_info.subnet_ids
    scaling_config = {
      desired_size = var.eks_ng_info.desired_size
      min_size     = var.eks_ng_info.min_size
      max_size     = var.eks_ng_info.max_size
    }

    update_config = {
      max_unavailable = var.eks_ng_info.max_unavailable
    }
  }

  depends_on = [
    data.aws_iam_role.eks_role,
    data.aws_iam_role.eks_ec2_role,
    data.aws_security_groups.security,
    data.aws_subnets.subnets
  ]
}