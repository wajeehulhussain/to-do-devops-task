resource "aws_security_group" "vpc_endpoint_sg" {
  name        = "${var.project}-${var.vpc_endpoint_sg}"
  description = var.vpc_endpoint_sg_des
  vpc_id      = var.vpc_id

  ingress {
    description = "Allowed private subnets for ssm"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.private_cidrs_blocks
  }

  ingress {
    description = "Allowed public subnets for ssm"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = var.public_cidrs_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.project}-${var.vpc_endpoint_sg}}"
    Owner = var.owner
  }
}

resource "aws_security_group" "eks_sg" {
  name   = format("%s-%s", var.project, var.eks_sg)
  vpc_id = var.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.linux_bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "${var.project}-${var.eks_sg}}"
    Owner = var.owner
  }
}

resource "aws_security_group" "linux_bastion_sg" {
  name   = format("%s-%s", var.project, var.bastion_sg)
  vpc_id = var.vpc_id

  ingress {
    description = "Allowed ssh from my laptop"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = [var.my_ip]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = format("%s-%s", var.project, var.bastion_sg)
    Owner = var.owner
  }
}


