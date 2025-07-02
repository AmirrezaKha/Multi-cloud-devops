# outputs.tf
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "s3_bucket" {
  value = module.s3.bucket_name
}

output "azure_blob_storage" {
  value = module.blob_storage.container_url
}