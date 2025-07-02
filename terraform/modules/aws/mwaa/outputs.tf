# outputs.tf
output "mwaa_environment_name" {
  value = aws_mwaa_environment.airflow.name
}

output "mwaa_webserver_url" {
  value = aws_mwaa_environment.airflow.webserver_url
}
