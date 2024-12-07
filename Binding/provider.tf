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
  chart      = "three-tier-app"
  version    = "0.1.0"
}
