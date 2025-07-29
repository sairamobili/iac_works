resource "azurerm_resource_group" "rg" {
  for_each = { for rg in var.resource_group_config : "${rg.name}-${rg.location}" => rg }
  name     = each.value.name
  location = each.value.location
  tags     = try(each.value.tags, null)
}
