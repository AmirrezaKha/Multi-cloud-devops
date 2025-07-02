# main.tf
resource "aws_redshift_cluster" "warehouse" {
  cluster_identifier = var.cluster_id
  node_type          = "dc2.large"
  number_of_nodes    = 2
  master_username    = var.username
  master_password    = var.password
  publicly_accessible = true
  tags               = var.tags
}
