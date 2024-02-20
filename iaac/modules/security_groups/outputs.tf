output "endpoint_sg" {
  value = aws_security_group.vpc_endpoint_sg
}

output "eks_sg_id" {
  value = aws_security_group.eks_sg.id
}

output "linux_bastion_sg" {
  value = aws_security_group.linux_bastion_sg.id
}
