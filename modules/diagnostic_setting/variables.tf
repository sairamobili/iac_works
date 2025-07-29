variable "dianostic_settings" {
  description = "Map of diagnostic settings to be applied to the resource"
  type = list(object({
    name                           = string
    target_resource_id             = string
    eventhub_name                  = optional(string)
    eventhub_authorization_rule_id = optional(string)
    enabled_log = optional(object({
      category       = optional(string)
      category_group = optional(string)
    }))
    log_analytics_workspace_id = optional(string)
    enabled_metric = optional(object({
      category = optional(string)
    }))
    stoage_account_id              = optional(string)
    log_analytics_destination_type = optional(string, )
    partner_solution_id            = optional(string)
  }))
  default = {}

}
