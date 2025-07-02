# main.tf
provider "azurerm" {
  features {}
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "helm_release" "airflow" {
  name       = "airflow"
  repository = "https://airflow.apache.org"
  chart      = "airflow"
  version    = var.airflow_helm_version
  namespace  = var.namespace

  depends_on = [azurerm_kubernetes_cluster.aks]

  set {
    name  = "executor"
    value = var.executor_type  # "CeleryExecutor" or "KubernetesExecutor"
  }

  set {
    name  = "webserver.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "dags.gitSync.enabled"
    value = true
  }

  set {
    name  = "dags.gitSync.repo"
    value = var.dags_git_repo
  }

  set {
    name  = "dags.gitSync.branch"
    value = var.dags_git_branch
  }
}
