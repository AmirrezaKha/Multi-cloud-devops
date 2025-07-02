# outputs.tf
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "airflow_helm_release" {
  value = helm_release.airflow.name
}
