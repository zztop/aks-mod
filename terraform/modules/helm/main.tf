provider "helm" {
  kubernetes {
    host     = var.host
    client_certificate     = var.client_certificate
    client_key             = var.client_key
    cluster_ca_certificate = var.cluster_ca_certificate
  }
}

resource "helm_release" "this" {
  name  = "my-api"
  chart = var.module_abspath
  namespace = var.namespace
}