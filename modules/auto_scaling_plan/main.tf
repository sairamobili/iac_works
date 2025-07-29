locals {
  scaling_plans_map = {
    for sp in var.scaling_plans : "${sp.resource_group_name}-${sp.name}" => sp
  }
}

resource "azurerm_virtual_desktop_scaling_plan" "this" {
  for_each = local.scaling_plans_map

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  time_zone           = each.value.time_zone
  description         = try(each.value.description, null)
  exclusion_tag       = try(each.value.exclusion_tag, null)
  tags                = try(each.value.tags, null)

  dynamic "schedule" {
    for_each = try(each.value.schedules, [])
    content {
      name                                 = schedule.value.name
      days_of_week                         = schedule.value.days_of_week
      ramp_up_start_time                   = schedule.value.ramp_up_start_time
      ramp_up_load_balancing_algorithm     = schedule.value.ramp_up_load_balancing_algorithm
      ramp_up_minimum_hosts_percent        = schedule.value.ramp_up_minimum_hosts_percent
      ramp_up_capacity_threshold_percent   = schedule.value.ramp_up_capacity_threshold_percent
      peak_start_time                      = schedule.value.peak_start_time
      peak_load_balancing_algorithm        = schedule.value.peak_load_balancing_algorithm
      ramp_down_start_time                 = schedule.value.ramp_down_start_time
      ramp_down_load_balancing_algorithm   = schedule.value.ramp_down_load_balancing_algorithm
      ramp_down_minimum_hosts_percent      = schedule.value.ramp_down_minimum_hosts_percent
      ramp_down_capacity_threshold_percent = schedule.value.ramp_down_capacity_threshold_percent
      ramp_down_force_logoff_users         = schedule.value.ramp_down_force_logoff_users
      ramp_down_wait_time_minutes          = schedule.value.ramp_down_wait_time_minutes
      ramp_down_notification_message       = try(schedule.value.ramp_down_notification_message, null)
      ramp_down_stop_hosts_when            = try(schedule.value.ramp_down_stop_hosts_when, null)
      off_peak_start_time                  = schedule.value.off_peak_start_time
      off_peak_load_balancing_algorithm    = schedule.value.off_peak_load_balancing_algorithm


    }
  }

  dynamic "host_pool" {
    for_each = try(each.value.host_pool, [])
    content {
      hostpool_id          = host_pool_reference.value.hostpool_id
      scaling_plan_enabled = host_pool_reference.value.scaling_plan_enabled
    }
  }
}
