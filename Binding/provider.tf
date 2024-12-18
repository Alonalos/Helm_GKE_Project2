provider "kubernetes" {
  config_path    = "~/.kube/config"
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
resource "helm_release" "example" {
  name       = "default"
  repository = "../three-tier-app" 
  chart      = "."
  version    = "0.1.0"
}
