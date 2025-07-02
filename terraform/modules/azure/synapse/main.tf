# main.tf
resource "azurerm_synapse_workspace" "synapse" {
  name                                 = var.synapse_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.storage_fs_id
  sql_administrator_login              = var.admin_user
  sql_administrator_login_password     = var.admin_pass
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}
