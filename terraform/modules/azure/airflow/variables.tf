# variables.tf
variable "aks_cluster_name" {
  description = "Name of AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in AKS"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "airflow_helm_version" {
  description = "Airflow Helm chart version"
  type        = string
  default     = "8.1.0" # check latest version
}

variable "namespace" {
  description = "Kubernetes namespace for Airflow"
  type        = string
  default     = "airflow"
}

variable "executor_type" {
  description = "Airflow executor type"
  type        = string
  default     = "CeleryExecutor"
}

variable "dags_git_repo" {
  description = "Git repo containing Airflow DAGs"
  type        = string
}

variable "dags_git_branch" {
  description = "Git branch for DAGs"
  type        = string
  default     = "main"
}
