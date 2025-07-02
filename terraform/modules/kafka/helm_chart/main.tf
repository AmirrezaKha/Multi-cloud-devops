# main.tf
resource "helm_release" "kafka" {
  name       = var.release_name
  chart      = var.chart
  repository = var.repository
  namespace  = var.namespace
  version    = var.chart_version

  values = [file("${path.module}/values.yaml")]
}
