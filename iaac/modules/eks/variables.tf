variable "cluster_name" {
  type        = string
  default     = "cluster"
  description = "The name of the cluster"
}
variable "eks_cluster_version" {
  type        = number
  default     = 1.28
  description = "The cluster version to be deployed"
  validation {
    condition     = var.eks_cluster_version >= 1.27
    error_message = "Err: The EKS Cluster version must be greater or equal to 1.27."
  }
}

variable "endpoint_private_access" {
  type        = bool
  default     = true
  description = "The EKS Cluster endpoint shouldn't be exposed"
  validation {
    condition     = var.endpoint_private_access == true
    error_message = "Err: The endpoint must be set to private."
  }
}

variable "endpoint_public_access" {
  type        = bool
  default     = false
  description = "The EKS Cluster endpoint shouldn't be publicly exposed."
  validation {
    condition     = var.endpoint_public_access == false
    error_message = "Err: The endpoint can't be exposed publicly."
  }
}

variable "fargate_profile_name" {
  type        = string
  default     = "fargate-profile"
  description = "The name of the Fargate profile"
}

variable "namespace" {
  type        = string
  default     = "my-app"
  description = "The namespace of the fargate profile"
  validation {
    condition = contains(
      ["my-app"],
      var.namespace
    )
    error_message = "Err: The namespace should correspond to the designated namespace."
  }
}

variable "eksaddons" {
  type        = list(string)
  default     = ["kube-proxy", "vpc-cni"]
  description = "list of available add-ons"
}

variable "owner" {
  type        = string
  description = "Name of the Owner"
}

variable "project" {
  type        = string
  description = "Name of the Project"
}

variable "passed_subnet_ids" {
  type        = list(string)
  description = "The Private Subnet IDs to be utilized for EKS"
}

variable "eks_roles_arn" {
  type        = list(any)
  description = "The EKS Cluster and Fargate Roles ARN to be utilized for EKS"
}
variable "security_group_ids" {
  type        = list(any)
  description = "The Security Group IDs to be utilized for EKS"
}

variable "forgate_configurations" {
  type = map(object({
    fargate_profile_name = string
    namespaces           = list(string)
  }))
  default = {
    "my-app" = {
      fargate_profile_name = "my-app-profile"
      namespaces           = ["my-app"]
    }
  }
}

variable "control_plan_logging" {
  type        = list(string)
  default     = ["audit", "api", "authenticator", "scheduler", "controllerManager"]
  description = "control plan logging for eks cluster"
}