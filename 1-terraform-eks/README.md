## Overview

This code will create a eks cluster with name sample-eks-cluster01, the workers will be hosted in a private subnet, with a nat gateway configured. The ALB will be create in the public subnet.

## Installation

You need to fill the *terraform.tfvars* with this variables:

```
AWS_ACCESS_KEY             = "aws-access-key"
AWS_SECRET_KEY             = "aws-secret-key"
AWS_REGION                 = "region"
SG_ALLOW_SSH               = "sg-id"
SSH_KEY_NAME               = "ssh-key-name"
VPC_ID                     = "vpc-id"
```

After that, you can plan and apply using terraform.

## Post commands

To download the kubeconfig file, you can run this command:

```bash
aws eks update-kubeconfig --name sample-eks-cluster01 --region <region> --kubeconfig ../../sample-eks-cluster01
```

The output will show ebsrolearn, to create the EBS CSI addon, run this command:

```bash
aws eks create-addon --cluster-name sample-eks-cluster01 --addon-name aws-ebs-csi-driver --region <region> --service-account-role-arn <ebsrolearn>
```