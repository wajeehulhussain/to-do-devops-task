#Creates two roles - EKS cluster role and EKS cluster pods execution role
resource "aws_iam_role" "eks_roles" {
  count = length(var.eks_cluster_roles)
  name  = var.eks_cluster_roles[count.index]
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : count.index == 0 ? "eks-fargate-pods.amazonaws.com" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name  = "${var.project}"
    Owner = var.owner
  }
}

resource "aws_iam_role_policy_attachment" "eks_roles_policies" {
  count      = length(var.eks_cluster_roles)
  role       = var.eks_cluster_roles[count.index]
  policy_arn = count.index == 0 ? "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy" : "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  depends_on = [aws_iam_role.eks_roles]
}

