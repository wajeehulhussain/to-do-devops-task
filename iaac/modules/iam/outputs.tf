output "eks_roles_arn" {
  value = [for role in aws_iam_role.eks_roles : role.arn]
}
