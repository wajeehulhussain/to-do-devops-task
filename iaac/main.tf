provider "aws" {
  region = "us-east-1"
}

# terraform {
#   backend "s3" {}
# }

####################### Modules Start #####################
# module "network" {
#   source = "./modules/vpc"

#   project              = var.project
#   owner                = var.owner
#   vpc_cidr             = var.vpc_cidr
#   aws_region           = var.aws_region
#   rtb_cidr             = var.rtb_cidr
#   private_subnet_cidrs = var.private_subnet_cidrs
#   public_subnet_cidrs  = var.public_subnet_cidrs
#   availability_zones   = var.availability_zones
# }

# module "iam" {
#   source  = "./modules/iam"
#   project = var.project
#   owner   = var.owner
# }

# module "eks" {
#   source = "./modules/eks"

#   project            = var.project
#   owner              = var.owner
#   passed_subnet_ids  = module.network.private_subnet_ids
#   eks_roles_arn      = module.iam.eks_roles_arn
#   security_group_ids = [module.security_groups.eks_sg_id]
# }

# module "security_groups" {
#   source = "./modules/security_groups"

#   project              = var.project
#   owner                = var.owner
#   vpc_id               = module.network.vpc.id
#   private_cidrs_blocks = module.network.private_subnet_cidrs
#   public_cidrs_blocks  = module.network.public_subnet_cidrs
#   eks_default_sg_id    = module.eks.cluster_security_group_id
# }

# module "vpc_endpoints" {
#   source = "./modules/vpc_endpoints"

#   project           = var.project
#   owner             = var.owner
#   vpc_id            = module.network.vpc.id
#   subnet_ids        = module.network.private_subnet_ids
#   route_table_id    = module.network.private_rtb_id
#   security_group_id = [module.security_groups.endpoint_sg.id]
# }

module "ecr_repos" {
  source = "./modules/ecr"

  project = var.project
  owner   = var.owner
}

# module "ec2_instance" {
#   source = "./modules/ec2_instance"

#   project   = var.project
#   owner     = var.owner
#   subnet_id = module.network.public_subnet_ids[0]
#   security_groups = [
#     module.security_groups.linux_bastion_sg
#   ]
# }