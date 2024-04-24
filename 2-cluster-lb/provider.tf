provider "helm" {
  kubernetes {
    config_path = "../../sample-eks-cluster01"
  }
}

provider "kubernetes" {
  config_path = "../../sample-eks-cluster01"
}


