locals {
  diagnostic_settings = [
    for ds in var.dianostic_settings : merge(
      ds,
      {
        target_resource_id = format(
          "/subscriptions/%s/resourceGroups/%s/providers/%s/%s",
          data.azurerm_subscription.current.subscription_id,
          ds.resource_group_name,
          ds.resource_type,
          ds.resource_name
        )
      }
    )
  ]
  diagnostic_settings_definitions = {for ds in local.diagnostic_settings : ds.target_resource_id => ds}
}