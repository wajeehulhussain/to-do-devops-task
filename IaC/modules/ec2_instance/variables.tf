variable "owner" {
  type        = string
  description = "Name of the Owner"
}

variable "project" {
  type        = string
  description = "Name of the Project"
}

variable "bastion_instance" {
  type        = list(string)
  default     = ["linux-bastion"]
  description = "Bastion instance for transact"
}

variable "volume_size" {
  type        = string
  default     = "50"
  description = "volume size"
}

variable "volume_type" {
  type        = string
  default     = "gp3"
  description = "volume type"
}

variable "security_groups" {
  type        = list(string)
  description = "bastion security group"
}

variable "subnet_id" {
  type        = string
  description = "subnet id"
}

variable "most_recent" {
  type        = bool
  default     = true
  description = "most recent ami"
}

variable "ami_name" {
  type        = string
  default     = "name"
  description = "filtered ami name"
}

variable "ami_value" {
  type        = string
  default     = "amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"
  description = "filtered ami"
}

variable "ebs_name" {
  type        = string
  default     = "root-device-type"
  description = "filtered ebs name"
}

variable "ebs_value" {
  type        = string
  default     = "ebs"
  description = "filtered ebs"
}

variable "ami_owner" {
  type        = string
  default     = "amazon"
  description = "filtered ami team name"
}

variable "instance_configurations" {
  type = map(object({
    instance_type      = string
    os_type            = string
    index              = number
    key_name           = string
    include_public_key = bool
    metadata_version   = string
    ami_id             = string
    lifecycle_tag      = bool
    root_ebs_size      = string
  }))
  default = {
    "linux-1" = {
      instance_type      = "t3.medium"
      os_type            = "linux"
      index              = 0
      key_name           = "wajeehs-bastion-key"
      include_public_key = true
      metadata_version   = "required"
      ami_id             = "ami-0cf10cdf9fcd62d37"
      lifecycle_tag      = true
      root_ebs_size      = "150"
    }
    # Add more instances if needed
  }
}

variable "vir_type" {
  type        = string
  default     = "virtualization-type"
  description = "virtualization type for windows instance"
}

variable "vir_type_value" {
  type        = string
  default     = "hvm"
  description = "virtualization type value for windows instance"
}

variable "ebs_configurations" {
  type = map(object({
    size        = number
    type        = string
    az          = string
    encrypted   = bool
    index       = number
    device_name = string
  }))
  default = {
    "linux" = {
      size        = 500
      type        = "gp3"
      az          = "eu-west-1a"
      encrypted   = true
      index       = 0
      device_name = "/dev/sdb"
    }
    # Add more instances if needed
  }
}

variable "mapmigrated" {
  type        = string
  default     = "migKD1BASL9B0"
  description = "Amazon map migrated"
}
