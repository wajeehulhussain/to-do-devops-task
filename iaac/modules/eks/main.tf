resource "aws_eks_cluster" "eks_cluster" {
  name                      = "${var.project}-${var.cluster_name}"
  role_arn                  = var.eks_roles_arn[1]
  version                   = var.eks_cluster_version
  enabled_cluster_log_types = var.control_plan_logging
  vpc_config {
    subnet_ids              = var.passed_subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    security_group_ids      = var.security_group_ids
  }

  tags = {
    Name  = "${var.project}-${var.cluster_name}"
    Owner = var.owner
  }
}

resource "aws_eks_addon" "eks_cluster_addons" {
  for_each     = { for i, addon in var.eksaddons : i => addon }
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = each.value
}

resource "aws_eks_fargate_profile" "eks_cluster_fargate_profile" {
  for_each = { for i, fargate_configuration in var.fargate_configurations : i => fargate_configuration }

  cluster_name           = aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = each.value.fargate_profile_name
  pod_execution_role_arn = var.eks_roles_arn[0]
  subnet_ids             = var.passed_subnet_ids

  dynamic "selector" {
    for_each = toset([for val in each.value.namespaces : { value = val }])

    content {
      namespace = selector.value.value
    }
  }
}