
output "ids" {
  description = "Map of Log Analytics Workspace resource IDs, keyed by <resource_group_name>-<name>."
  value = { for k, ws in azurerm_log_analytics_workspace.this : k => ws.id }
}

output "names" {
  description = "Map of Log Analytics Workspace names, keyed by <resource_group_name>-<name>."
  value = { for k, ws in azurerm_log_analytics_workspace.this : k => ws.name }
}

output "workspace_ids" {
  description = "Map of Log Analytics Workspace (customer) IDs, keyed by <resource_group_name>-<name>."
  value = { for k, ws in azurerm_log_analytics_workspace.this : k => ws.workspace_id }
}

output "primary_shared_keys" {
  description = "Map of primary shared keys for each workspace, keyed by <resource_group_name>-<name>."
  value = { for k, ws in azurerm_log_analytics_workspace.this : k => ws.primary_shared_key }
}

output "secondary_shared_keys" {
  description = "Map of secondary shared keys for each workspace, keyed by <resource_group_name>-<name>."
  value = { for k, ws in azurerm_log_analytics_workspace.this : k => ws.secondary_shared_key }
}
