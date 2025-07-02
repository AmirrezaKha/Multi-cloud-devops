# main.tf
resource "azurerm_storage_account" "blob" {
  name                     = var.account_name
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "data_lake" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.blob.name
  container_access_type = "private"
}
