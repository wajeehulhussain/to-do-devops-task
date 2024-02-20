
variable "owner" {
  type        = string
  description = "Name of the Owner"
}

variable "project" {
  type        = string
  description = "Name of the Project"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private Subnet IDs For Interface and Gateway Endpoints"
}

variable "security_group_id" {
  type        = list(string)
  description = "Security Group For Interface Endpoints"

}

variable "vpc_id" {
  type        = string
  description = "VPC ID for Interface and Gateway Endpoints"
}

variable "vpc_endpoint_type_interface" {
  type        = string
  description = "Type of the Endpoint"
  default     = "Interface"

}

variable "vpc_endpoint_type_gateway" {
  type        = string
  description = "Type of the Endpoint"
  default     = "Gateway"

}

variable "private_dns_enabled" {
  type        = string
  description = "Private DNS Setting Whether or not to associate a private hosted zone with the specified VPC"
  default     = "true"
}


variable "s3_service_name" {
  type        = string
  description = "Endpoint Service Name"
  default     = "com.amazonaws.us-east-1.s3"
}

variable "route_table_id" {
  type        = string
  description = "Route Table ID for Gateway Endpoint"
}

variable "interface_service_name" {
  description = "Endpoint Service Name"
  type        = list(string)
  default = [
    "com.amazonaws.us-east-1.elasticloadbalancing",
    "com.amazonaws.us-east-1.ec2messages",
    "com.amazonaws.us-east-1.ssmmessages",
    "com.amazonaws.us-east-1.ssm",
    "com.amazonaws.us-east-1.eks",
    "com.amazonaws.us-east-1.ec2",
    "com.amazonaws.us-east-1.sts",
  ]
}

variable "tags_service_name" {
  description = "Tag Names of the Service Endpoint"
  type        = list(string)
  default = [
    "elasticloadbalancing",
    "ec2messages",
    "smmessages",
    "ssm",
    "eks",
    "ec2",
    "sts"
  ]
}