resource "azurerm_virtual_desktop_workspace" "workspace" {
  for_each                      = var.workspaces
  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  friendly_name                 = each.value.friendly_name
  description                   = each.value.description
  public_network_access_enabled = each.value.public_network_access_enabled
  tags                          = each.value.tags
}

output "workspace_ids" {
  value = { for k, v in azurerm_virtual_desktop_workspace.workspace : k => v.id }
}