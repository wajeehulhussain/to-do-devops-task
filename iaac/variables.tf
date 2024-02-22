#######################  Generic Variables #####################
variable "project" {
  type        = string
  description = "project name"
  default     = "to-do-app"
  validation {
    condition     = contains(["to-do-app"], var.project)
    error_message = "Err: Environment should be 'to-do-app'."
  }
}
variable "owner" {
  type        = string
  default     = "syedmuhammadwajeeh@gmail.com"
  description = " Name"
  validation {
    condition = contains(
      [
       "syedmuhammadwajeeh@gmail.com"
      ],
      var.owner
    )
    error_message = "Err: Must be a valid name of Owner."
  }
}
variable "aws_region" {
  type        = string
  description = "vpc region"
}

# variable "profile" {
#   type        = string
#   description = "AWS profile to use"
# }

####################### Modules Start #####################

variable "vpc_cidr" {
  type        = string
  description = "vpc cidr block"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "public subnet cidr blocks"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "private subnet cidr blocks"
}

variable "availability_zones" {
  description = "AZs"
  type        = list(string)
}

variable "rtb_cidr" {
  type        = string
  description = "route table cidr blocks"
}