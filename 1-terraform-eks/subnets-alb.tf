resource "aws_subnet" "public-sample-k8s-subnet-a" {
  vpc_id     = var.VPC_ID
  cidr_block = "10.0.60.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name                              = "public-sample-k8s-subnet-a"
    "kubernetes.io/role/elb"          = ""
    "kubernetes.io/role/internal-elb" = ""
  }
}

resource "aws_subnet" "public-sample-k8s-subnet-b" {
  vpc_id     = var.VPC_ID
  cidr_block = "10.0.61.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name                              = "public-sample-k8s-subnet-b"
    "kubernetes.io/role/elb"          = ""
    "kubernetes.io/role/internal-elb" = ""
  }
}