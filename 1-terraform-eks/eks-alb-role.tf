resource "aws_iam_role" "lb_controller_role" {
  name = "awsloadbalancercontrolleriamrole"

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
          "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }]
  })
  
}

resource "aws_iam_policy" "lb_controller_policy" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  description = "Policy for AWS Load Balancer Controller"
    
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "wafv2:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "waf-regional:*",
      "Resource": "*"
    },    
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "acm:DescribeCertificate",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "acm:ListCertificates",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "acm:GetCertificate",
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

resource "aws_iam_role_policy_attachment" "lb_controller_policy_attachment" {
  policy_arn = aws_iam_policy.lb_controller_policy.arn
  role       = aws_iam_role.lb_controller_role.name
}
