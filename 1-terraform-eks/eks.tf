resource "aws_eks_cluster" "sample-eks-cluster01" {
  name     = "sample-eks-cluster01"
  role_arn = aws_iam_role.sample-eks-role.arn
  
  vpc_config {
    subnet_ids = [aws_subnet.sample-k8s-subnet-a.id, aws_subnet.sample-k8s-subnet-b.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.sample-eks-role-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.sample-eks-role-AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "sample-eks-cluster01-wk" {
  cluster_name    = aws_eks_cluster.sample-eks-cluster01.name
  node_group_name = "sample-eks-cluster01-workers"
  node_role_arn   = aws_iam_role.sample-eks-role.arn
  subnet_ids      = [aws_subnet.sample-k8s-subnet-a.id, aws_subnet.sample-k8s-subnet-b.id]
  ami_type        = "AL2_x86_64"
  instance_types  = ["t2.medium"]

  remote_access {
    ec2_ssh_key = var.SSH_KEY_NAME
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.sample-eks-role-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.sample-eks-role-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.sample-eks-role-AmazonEC2ContainerRegistryReadOnly,
  ]
  
}