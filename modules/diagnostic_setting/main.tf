resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings" {
  for_each = local.diagnostic_settings_definitions

  name                           = each.value.name
  target_resource_id             = each.value.target_resource_id
  eventhub_name                  = each.value.eventhub_name
  eventhub_authorization_rule_id = each.value.eventhub_authorization_rule_id
  log_analytics_workspace_id     = each.value.log_analytics_workspace_id
  storage_account_id             = each.value.stoage_account_id
  log_analytics_destination_type = each.value.log_analytics_destination_type
  partner_solution_id            = each.value.patner_solution_id

  dynamic "enabled_log" {
    for_each = each.value.enabled_log != null ? [each.value.enabled_log] : []
    content {
      category       = enabled_log.value.category
      category_group = enabled_log.value.category_group
    }
  }

  dynamic "enabled_metric" {
    for_each = each.value.enabled_metric != null ? [each.value.enabled_metric] : []
    content {
      category = enabled_metric.value.category
    }
  }

}
