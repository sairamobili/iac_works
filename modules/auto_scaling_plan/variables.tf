variable "scaling_plans" {
  description = "List of Virtual Desktop Scaling Plan definitions."
  type = list(object({
    name                = string
    resource_group_name = string
    location            = string
    time_zone           = string
    description         = optional(string)
    exclusion_tag       = optional(string)
    tags                = optional(map(string))
    schedules = list(object({
      name                                 = string
      days_of_week                         = list(string)
      ramp_up_start_time                   = string
      ramp_up_load_balancing_algorithm     = string
      ramp_up_minimum_hosts_percent        = number
      ramp_up_capacity_threshold_percent   = number
      peak_start_time                      = string
      peak_load_balancing_algorithm        = string
      ramp_down_start_time                 = string
      ramp_down_load_balancing_algorithm   = string
      ramp_down_minimum_hosts_percent      = number
      ramp_down_capacity_threshold_percent = number
      ramp_down_force_logoff_users         = bool
      ramp_down_wait_time_minutes          = number
      ramp_down_notification_message       = optional(string)
      ramp_down_stop_hosts_when            = optional(string)
      off_peak_start_time                  = string
      off_peak_load_balancing_algorithm    = string
    }))
    host_pool = list(object({
      hostpool_id          = string
      scaling_plan_enabled = bool
    }))
  }))
}
