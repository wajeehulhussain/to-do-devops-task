project    = "to-do-app"
owner      = "syedmuhammadwajeeh@gmail.com"
aws_region = "us-east-1"
# profile = "wajeehs-profile"

####################### Main Module #####################
vpc_cidr             = "10.10.0.0/20"
private_subnet_cidrs = ["10.10.12.0/24", "10.10.14.0/24", "10.10.15.0/24"]
public_subnet_cidrs  = ["10.10.0.0/24", "10.10.4.0/24", "10.10.8.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
rtb_cidr             = "0.0.0.0/0"