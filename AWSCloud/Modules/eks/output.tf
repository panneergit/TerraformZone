output "cluster_id" {
   value       = try(aws_eks_cluster.this[0].cluster_id, "")
   description = "The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts"
}

output "cluster_version" {
  description = "The Kubernetes version for the cluster"
  value       = try(aws_eks_cluster.this[0].version, null)
}