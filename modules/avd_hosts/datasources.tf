data "azurerm_subscription" "current" {
  # This data source retrieves the current subscription details
  # It is used to reference the subscription ID in other resources

}

data "azurerm_subnet" "subnet" {
  for_each = local.subnet_map
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}