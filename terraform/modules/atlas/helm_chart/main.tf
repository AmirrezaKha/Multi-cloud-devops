# main.tf
resource "helm_release" "atlas" {
  name       = var.release_name
  repository = var.helm_repo
  chart      = var.chart_name
  version    = var.chart_version
  namespace  = var.namespace
  values     = [file("${path.module}/values.yaml")]
}