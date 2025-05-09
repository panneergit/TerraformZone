eks_ima_role = "my-eks-cluster-role"

eks_ec2_iam_role = "my_eks_ec2_ng"

eks_info = {
  name           = "aws-eks-cluster"
  version        = "1.31"
  addons         = true
  auth_mode      = "API_AND_CONFIG_MAP"
  public_access  = true
  private_access = true
  public_cidrs   = ["0.0.0.0/0"]
  subnet_ids     = ["subnet-0c412fbab7e515c66", "subnet-0b0e241e197965879", "subnet-0e88221a568725d3b"]
}

eks_ng_info = {
  name           = "aws-eks-node-group"
  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.micro"]
  subnet_ids     = ["subnet-0c412fbab7e515c66", "subnet-0b0e241e197965879", "subnet-0e88221a568725d3b"]

  desired_size = 1
  min_size     = 1
  max_size     = 1

  max_unavailable = 1
}