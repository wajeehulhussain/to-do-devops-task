variable "eks_cluster_roles" {
  description = "List of EKS Cluster role names"
  type        = list(string)
  default     = ["wajeehs-eks-pod-execution-role", "wajeehs-eks-cluster-role"]
}

variable "owner" {
  type        = string
  description = "Name of the Owner"
}

variable "project" {
  type        = string
  description = "Name of the Project"
}

