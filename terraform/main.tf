# main.tf
module "eks" {
  source     = "./modules/aws/eks"
  aws_region = var.aws_region
}

module "aks" {
  source          = "./modules/azure/aks"
  azure_location  = var.azure_location
}

module "s3" {
  source     = "./modules/aws/s3"
  aws_region = var.aws_region
}

module "blob_storage" {
  source          = "./modules/azure/blob_storage"
  azure_location  = var.azure_location
}

module "redshift" {
  source     = "./modules/aws/redshift"
  aws_region = var.aws_region
}

module "synapse" {
  source          = "./modules/azure/synapse"
  azure_location  = var.azure_location
}

module "kafka" {
  source = "./modules/kafka/helm_chart"
}

module "airflow" {
  source = "./modules/airflow/helm_chart"
}

module "spark_trino" {
  source = "./modules/spark_trino/helm_chart"
}

module "atlas" {
  source = "./modules/atlas/helm_chart"
}