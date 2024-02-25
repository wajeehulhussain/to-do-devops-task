variable "ecr_name" {
  type        = string
  default     = "ecr-repo"
  description = "Elastic container registry"
}

variable "owner" {
  type        = string
  description = "Name of the Owner"
}

variable "project" {
  type        = string
  description = "Name of the Project"
}

variable "image_tag_mutability" {
  type        = string
  default     = "IMMUTABLE"
  description = "image tag mutability"
}

variable "force_delete" {
  type        = bool
  default     = false
  description = "force delete"
}

variable "enc_type" {
  type        = string
  default     = "AES256"
  description = "encryption type"
}

variable "scan_on_push" {
  type        = bool
  default     = true
  description = "scan on push"
}