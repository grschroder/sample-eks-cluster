data "tls_certificate" "sample-eks-cluster01-certificates" {
  url = aws_eks_cluster.sample-eks-cluster01.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {  
  url = data.tls_certificate.sample-eks-cluster01-certificates.url  
  client_id_list    = ["sts.amazonaws.com"]  
  thumbprint_list    = [data.tls_certificate.sample-eks-cluster01-certificates.certificates[0].sha1_fingerprint]
}