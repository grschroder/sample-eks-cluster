variable "AWS_REGION" {
  description = "The AWS region"
  default     = "us-east-1"
}

variable "AWS_ACCESS_KEY" {
  description = "The AWS access"
  default     = "access-key"
}

variable "AWS_SECRET_KEY" {
  description = "The AWS secret key"
  default     = "key"
}


variable "VPC_ID" {
    description = "VPC ID generated on step 1"
  
}

variable "LB_IAM_ROLE_ARN" {
    description = "IAM Role ARN for AWS Load Balancer Controller generated on step 1"
  
}