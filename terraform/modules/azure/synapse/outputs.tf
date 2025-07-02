# outputs.tf
output "synapse_workspace_id" {
  value = azurerm_synapse_workspace.synapse.id
}
