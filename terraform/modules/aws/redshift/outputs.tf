# outputs.tf
output "endpoint" {
  value = aws_redshift_cluster.warehouse.endpoint
}
