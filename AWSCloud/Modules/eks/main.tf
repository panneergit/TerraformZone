# Resource for EKS Cluster
resource "aws_eks_cluster" "this" {
  name                          = var.aws_eks_cluster_info.name
  version                       = var.aws_eks_cluster_info.version
  role_arn                      = var.aws_eks_cluster_info.eks_role_arn
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
    security_group_ids      = var.aws_eks_cluster_info.vpc_config.security_group_ids
    subnet_ids              = var.aws_eks_cluster_info.vpc_config.subnet_ids
  }
}

# Resiource EKS Node Group and EC2 Resources
resource "aws_eks_node_group" "this" {
  node_group_name = var.aws_eks_node_group_info.name
  cluster_name    = aws_eks_cluster.this.name
  node_role_arn   = var.aws_eks_node_group_info.node_role_arn
  version         = aws_eks_cluster.this.version
  subnet_ids      = var.aws_eks_node_group_info.subnet_ids

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
    aws_eks_cluster.this
  ]
}
