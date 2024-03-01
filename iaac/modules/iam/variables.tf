variable "eks_cluster_roles" {
  description = "List of EKS Cluster role names"
  type        = list(string)
  default     = ["to-do-app-eks-pod-execution-role", "to-do-app-eks-cluster-role"]
}

variable "owner" {
  type        = string
  description = "Name of the Owner"
}

variable "project" {
  type        = string
  description = "Name of the Project"
}

