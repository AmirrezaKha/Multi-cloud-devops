# variables.tf
variable "release_name" {
  type        = string
  description = "Helm release name"
}

variable "chart" {
  type        = string
  default     = "kafka"
  description = "Chart name"
}

variable "repository" {
  type        = string
  default     = "https://charts.bitnami.com/bitnami"
  description = "Chart repository"
}

variable "namespace" {
  type        = string
  default     = "kafka"
  description = "Kubernetes namespace"
}

variable "chart_version" {
  type        = string
  default     = "20.0.1"
  description = "Kafka Helm chart version"
}
