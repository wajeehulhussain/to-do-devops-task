variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "owner" {
  type        = string
  description = "Name of the Owner"
}

variable "project" {
  type        = string
  description = "Name of the Project"
}

variable "vpc_endpoint_sg" {
  type        = string
  default     = "vpc-endpoint-sg"
  description = "wajeehs vpc_point security group"
}

variable "vpc_endpoint_sg_des" {
  type        = string
  default     = "wajeehs vpc_endpoint security group"
  description = "wajeehs vpc_endpoint security group"
}

variable "eks_sg" {
  type        = string
  default     = "eks-sg"
  description = "eks security group"
}

variable "bastion_sg" {
  type        = string
  default     = "bastion-sg"
  description = "linux and windows bastion security group"
}

variable "public_cidrs_blocks" {
  type        = list(string)
  description = "public subnets cidrs"
}

variable "private_cidrs_blocks" {
  type        = list(string)
  description = "private subnets cidrs"
}

variable "my_ip" {
  type        = string
  default     = "172.28.240.1/32"
  description = "My Machines IP"
}

variable "eks_default_sg_id" {
  type        = string
  description = "eks default security group"
}

