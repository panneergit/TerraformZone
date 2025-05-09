# Get IAM Role for EKS Cluster
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

# Resource for EKS Cluster
resource "aws_eks_cluster" "this" {
  name                          = var.aws_eks_cluster_info.name
  version                       = var.aws_eks_cluster_info.version
  role_arn                      = data.aws_iam_role.eks_role.arn
  bootstrap_self_managed_addons = var.aws_eks_cluster_info.self_managed_addons
  access_config {
    authentication_mode = var.aws_eks_cluster_info.access_config.authentication_mode
  }
  #   compute_config {
  #     enabled = true
  #   }

  #   kubernetes_network_config {
  #     elastic_load_balancing {
  #       enabled = true
  #     }
  #   }
  vpc_config {
    endpoint_public_access  = var.aws_eks_cluster_info.vpc_config.public_access
    endpoint_private_access = var.aws_eks_cluster_info.vpc_config.private_access
    public_access_cidrs     = var.aws_eks_cluster_info.vpc_config.public_cidrs
    security_group_ids      = data.aws_security_groups.security.ids
    subnet_ids              = data.aws_subnets.subnets.ids
  }

  depends_on = [
    data.aws_iam_role.eks_role,
    data.aws_security_groups.security,
    data.aws_subnets.subnets
  ]
}

# Resiource EKS Node Group and EC2 Resources
resource "aws_eks_node_group" "this" {
  node_group_name = var.aws_eks_node_group_info.name
  cluster_name    = aws_eks_cluster.this.name
  node_role_arn   = data.aws_iam_role.eks_ec2_role.arn
  version         = aws_eks_cluster.this.version
  subnet_ids      = data.aws_subnets.subnets.ids

  ami_type       = var.aws_eks_node_group_info.ami_type
  instance_types = var.aws_eks_node_group_info.instance_types
  capacity_type  = var.aws_eks_node_group_info.capacity_type

  scaling_config {
    desired_size = var.aws_eks_node_group_info.scaling_config.desired_size
    min_size     = var.aws_eks_node_group_info.scaling_config.min_size
    max_size     = var.aws_eks_node_group_info.scaling_config.max_size
  }

  update_config {
    max_unavailable = var.aws_eks_node_group_info.update_config.max_unavailable
  }

  depends_on = [
    aws_eks_cluster.this,
    data.aws_iam_role.eks_ec2_role,
    data.aws_subnets.subnets
  ]
}
