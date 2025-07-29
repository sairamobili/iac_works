variable "host_pools" {
  type = map(object({
    name                     = string
    location                 = string
    resource_group_name      = string
    type                     = string
    load_balancer_type       = string
    friendly_name            = optional(string)
    validate_environment     = optional(bool, false)
    start_vm_on_connect      = optional(bool, false)
    custom_rdp_properties    = optional(string)
    description              = optional(string)
    maximum_sessions_allowed = optional(number)
    rotation_days            = optional(number, 24)
    scheduled_agent_updates = optional(object({
      enabled  = optional(bool)
      timezone = optional(string)
      schedule = optional(list(object({
        day_of_week = string
        hour_of_day = number
      })))
    }))
  }))
  description = "Map of host pool configurations."
}