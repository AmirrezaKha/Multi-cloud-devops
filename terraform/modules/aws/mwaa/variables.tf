# variables.tf
variable "environment_name" {
  description = "MWAA environment name"
  type        = string
}

variable "airflow_version" {
  description = "Airflow version"
  type        = string
  default     = "2.4.3"
}

variable "environment_class" {
  description = "MWAA environment class (e.g., mw1.small)"
  type        = string
  default     = "mw1.small"
}

variable "execution_role_arn" {
  description = "IAM Role ARN for MWAA execution"
  type        = string
}

variable "source_bucket_arn" {
  description = "S3 bucket ARN that contains DAGs and plugins"
  type        = string
}

variable "dag_s3_path" {
  description = "Path inside the bucket where DAGs are stored"
  type        = string
  default     = "dags"
}

variable "subnet_ids" {
  description = "List of subnet IDs for MWAA environment"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for MWAA environment"
  type        = list(string)
}

variable "max_workers" {
  description = "Maximum number of workers"
  type        = number
  default     = 5
}

variable "max_scheduler_workers" {
  description = "Maximum number of scheduler workers"
  type        = number
  default     = 2
}
