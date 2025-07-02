# main.tf
resource "aws_mwaa_environment" "airflow" {
  name                = var.environment_name
  airflow_version     = var.airflow_version
  environment_class   = var.environment_class
  execution_role_arn  = var.execution_role_arn
  source_bucket_arn   = var.source_bucket_arn
  dag_s3_path         = var.dag_s3_path
  logging_configuration {
    task_logs {
      enabled = true
      log_level = "INFO"
    }
    scheduler_logs {
      enabled = true
      log_level = "INFO"
    }
    webserver_logs {
      enabled = true
      log_level = "INFO"
    }
    worker_logs {
      enabled = true
      log_level = "INFO"
    }
  }
  network_configuration {
    subnet_ids = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
  webserver_access_mode = "PUBLIC_ONLY" # or PRIVATE_ONLY if VPC private access
  max_workers = var.max_workers
  max_scheduler_workers = var.max_scheduler_workers
}
