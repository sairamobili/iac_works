resource "azurerm_virtual_desktop_application_group" "dag" {
  for_each            = var.application_groups
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  name                = each.value.name
  type                = each.value.type
  host_pool_id        = var.host_pool_ids["${each.value.resource_group_name}-${each.value.host_pool_name}"]
  friendly_name       = each.value.friendly_name
  description         = each.value.description
}

output "application_group_ids" {
  value = { for k, v in azurerm_virtual_desktop_application_group.dag : k => v.id }
}