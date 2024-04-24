resource "aws_iam_role" "ebs-csi-role" {
  name = "ebs-csi-controller-role"

  assume_role_policy = jsonencode({
    Version     = "2012-10-17",
    Statement   = [{
      Action    = "sts:AssumeRoleWithWebIdentity",
      Effect    = "Allow",
      Principal = {
        Federated = aws_iam_openid_connect_provider.eks_oidc_provider.arn
      },
      Condition = {
        StringEquals = {
          "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }]
  })
  
}

resource "aws_iam_policy" "ebs-controller-policy" {
  name        = "AmazonEKS_EBS_CSI_DriverRole"
  description = "Policy for AWS EBS CSI Controller"
    
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }, 
    {
      "Effect": "Allow",
      "Action": "tag:GetResources",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "tag.kubernetes.io/cluster/sample-eks-cluster01": "owned"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ebs-csi-policy-attachment" {
  policy_arn = aws_iam_policy.ebs-controller-policy.arn
  role       = aws_iam_role.ebs-csi-role.name
}