# main.tf
resource "helm_release" "spark_trino" {
  name       = var.release_name
  repository = var.helm_repo
  chart      = var.chart_name
  version    = var.chart_version
  namespace  = var.namespace
  values     = [file("${path.module}/values.yaml")]
}

### File: modules/spark_trino/helm_chart/variables.tf
variable "release_name" {}
variable "helm_repo" {}
variable "chart_name" {}
variable "chart_version" {}
variable "namespace" {}
