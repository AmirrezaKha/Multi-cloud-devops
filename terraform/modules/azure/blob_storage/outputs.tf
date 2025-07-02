# outputs.tf
output "storage_account_name" {
  value = azurerm_storage_account.blob.name
}

output "container_name" {
  value = azurerm_storage_container.data_lake.name
}
