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

variable "SG_ALLOW_SSH" {
  description = "Security group allow SSH"
  
}

variable "SSH_KEY_NAME" {
  description = "SSH key name"
  
}

variable "VPC_ID" {
  default = "VPC ID to host eks cluster"
}
