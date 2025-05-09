eks_ima_role = "my-eks-cluster-role"

eks_ec2_iam_role = "my_eks_ec2_ng"

aws_eks_cluster_info = {
  name                = "my_eks_cluster"
  version             = "1.31"
  self_managed_addons = true
  access_config = {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
  vpc_config = {
    private_access = true
    public_access  = true
    public_cidrs   = ["0.0.0.0/0"]
  }
}

aws_eks_node_group_info = {
  name           = "eks_clsuer_node_group"
  ami_type       = "AL2_x86_64"
  instance_types = ["t2.micro"]
  capacity_type  = "ON_DEMAND"
  scaling_config = {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }
  update_config = {
    max_unavailable = 1
  }
}