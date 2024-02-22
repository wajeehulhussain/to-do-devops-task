variable "vpc_cidr" {
  type        = string
  description = "vpc cidr block"
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
  description = "enabled dns hostnames"
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "enabled dns support"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "vpc region"
}


variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for app subnets"
  type        = list(string)
}
variable "availability_zones" {
  description = "AZs"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]

  validation {
    condition = alltrue([
      for azs in var.availability_zones : can(regex("^us-east-1*", azs))
    ])
    error_message = "Err: Availability Zones should be between 'us-east-1a' or 'us-east-1b' or 'us-east-1c'."
  }
}

variable "rtb_cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "route table cidr blocks"
  validation {
    condition     = cidrnetmask(var.rtb_cidr) == "0.0.0.0"
    error_message = "Expecting a /0 for this ROUTE_TABLE!"
  }
}
variable "tenancy" {
  type        = string
  default     = "default"
  description = "vpc tenancy"
  validation {
    condition     = contains(["default", "dedicated"], var.tenancy)
    error_message = "VPC tenancy should be between default, dedicated."
  }
}

variable "owner" {
  type        = string
  description = "Name of the Owner"
}

variable "project" {
  type        = string
  description = "Name of the Project"
}

variable "public_subnet_name" {
  type    = string
  default = "public"
}

variable "private_subnet_name" {
  type    = string
  default = "private"
}
variable "type" {
  type        = string
  default     = "shared"
  description = "eks cluster subnet type tag"
}
variable "elb_value" {
  type        = number
  default     = 1
  description = "eks cluster subnet elb value tag"
}
variable "role_path" {
  type        = string
  default     = "role/internal-elb"
  description = "eks cluster subnet elb url tag"
}
variable "eks_cluster_name" {
  type        = string
  default     = "to-do-app-cluster"
  description = "cluster name"
}
variable "kubernetes_url" {
  type        = string
  default     = "kubernetes.io"
  description = "eks kubernetes url for tag"
}
variable "resource_type" {
  type        = string
  default     = "cluster"
  description = "resource type for tag"
}