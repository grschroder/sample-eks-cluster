## Requirements

You need to run:

```bash
helm repo update
```
Create *terraform.tfvars* file and fill with you data. You can use the awsloadbalancercontrolleriamrole ARN created on step 1 of this guide.

```
AWS_ACCESS_KEY             = "aws-access-key"
AWS_SECRET_KEY             = "aws-secret-key"
AWS_REGION                 = "region"
VPC_ID                     = "vpc-id"
LB_IAM_ROLE_ARN            = "arn-awsloadbalancercontrolleriamrole"
```

Be sure to have the kubeconfig file two folder levels above here.

Then you can run terraform plan and apply.