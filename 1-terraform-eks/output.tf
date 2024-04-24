output "endpoint" {
  value = aws_eks_cluster.sample-eks-cluster01.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.sample-eks-cluster01.certificate_authority[0].data
}

output "lb_controller_role" {
  value = aws_iam_role.lb_controller_role.arn
  
}

output "ebs_csi_role" {
  value = aws_iam_role.ebs-csi-role.arn
  
}