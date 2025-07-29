resource "azurerm_virtual_desktop_host_pool" "host_pool" {
  for_each                 = var.host_pools
  location                 = each.value.location
  resource_group_name      = each.value.resource_group_name
  name                     = each.value.name
  type                     = each.value.type
  friendly_name            = each.value.friendly_name
  validate_environment     = each.value.validate_environment
  start_vm_on_connect      = each.value.start_vm_on_connect
  custom_rdp_properties    = each.value.custom_rdp_properties
  description              = each.value.description
  maximum_sessions_allowed = each.value.maximum_sessions_allowed
  load_balancer_type       = each.value.load_balancer_type

  dynamic "scheduled_agent_updates" {
    for_each = each.value.scheduled_agent_updates != null ? [each.value.scheduled_agent_updates] : []
    content {
      enabled  = scheduled_agent_updates.value.enabled
      timezone = scheduled_agent_updates.value.timezone
      dynamic "schedule" {
        for_each = scheduled_agent_updates.value.schedule != null ? scheduled_agent_updates.value.schedule : []
        content {
          day_of_week = schedule.value.day_of_week
          hour_of_day = schedule.value.hour_of_day
        }
      }
    }
  }
}

resource "time_rotating" "rotate_days" {
  for_each      = var.host_pools
  rotation_days = each.value.rotation_days
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo" {
  for_each        = var.host_pools
  hostpool_id     = azurerm_virtual_desktop_host_pool.host_pool[each.key].id
  expiration_date = time_rotating.rotate_days[each.key].rotation_rfc3339
}

output "host_pool_ids" {
value       = { for key,value in azurerm_virtual_desktop_host_pool.host_pool : key => value.id }
  description = "Map of host pool IDs."
}

output "host_pool_registration_info" {
  value       = { for key, value in azurerm_virtual_desktop_host_pool_registration_info.registrationinfo : key => value.token }
  description = "Map of host pool registration information."
  
}