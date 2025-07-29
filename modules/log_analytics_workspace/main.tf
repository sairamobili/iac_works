
locals {
  workspaces_map = {
    for ws in var.workspaces :
    "${ws.resource_group_name}-${ws.name}" => ws
  }
}

resource "azurerm_log_analytics_workspace" "this" {
  for_each = local.workspaces_map

  name                                = each.value.name
  location                            = each.value.location
  resource_group_name                  = each.value.resource_group_name
  sku                                 = each.value.sku
  retention_in_days                    = each.value.retention_in_days
  daily_quota_gb                       = each.value.daily_quota_gb
  internet_ingestion_enabled           = each.value.internet_ingestion_enabled
  internet_query_enabled               = each.value.internet_query_enabled
  reservation_capacity_in_gb_per_day   = each.value.reservation_capacity_in_gb_per_day
  cmk_for_query_forced                 = each.value.cmk_for_query_forced
  allow_resource_only_permissions      = each.value.allow_resource_only_permissions
  # local_authentication_disabled is not a valid argument for azurerm_log_analytics_workspace
  tags                                 = each.value.tags

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
