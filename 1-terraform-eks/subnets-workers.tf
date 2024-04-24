resource "aws_eip" "eip-sample-k8s-nat" {    
    
    tags = {
        Name = "ei-sample-k8s-nat"
    }
}

resource "aws_nat_gateway" "nat-gw-sample-k8s" {
  allocation_id = aws_eip.eip-sample-k8s-nat.id
  subnet_id     = aws_subnet.public-sample-k8s-subnet-a.id

  tags = {
    Name = "nat-gw-sample-k8s"
  }

  
}

resource "aws_route_table" "rtable-priv-default" {
  vpc_id = var.VPC_ID

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw-sample-k8s.id
    }

  tags = {
    Name = "rtable-priv-default"
  }

}

resource "aws_subnet" "sample-k8s-subnet-a" {
  vpc_id                  = var.VPC_ID
  cidr_block              = "10.0.50.0/24"
  #map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "sample-k8s-subnet-a"    
  }
}

resource "aws_subnet" "sample-k8s-subnet-b" {
  vpc_id                  = var.VPC_ID
  cidr_block              = "10.0.51.0/24"
  #map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "sample-k8s-subnet-b"
  }
}

resource "aws_route_table_association" "rtable-association-a" {
  subnet_id      = aws_subnet.sample-k8s-subnet-a.id
  route_table_id = aws_route_table.rtable-priv-default.id  
}

resource "aws_route_table_association" "rtable-association-b" {
  subnet_id      = aws_subnet.sample-k8s-subnet-b.id
  route_table_id = aws_route_table.rtable-priv-default.id  
}