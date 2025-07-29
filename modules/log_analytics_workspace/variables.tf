
variable "workspaces" {
  description = "List of Log Analytics Workspace definitions."
  type = list(object({
    name                                = string
    location                            = string
    resource_group_name                  = string
    sku                                 = string
    retention_in_days                    = optional(number, 30)
    daily_quota_gb                       = optional(number)
    internet_ingestion_enabled           = optional(bool)
    internet_query_enabled               = optional(bool)
    reservation_capacity_in_gb_per_day   = optional(number)
    cmk_for_query_forced                 = optional(bool)
    allow_resource_only_permissions      = optional(bool)
    local_authentication_enabled        = optional(bool)
    tags                                 = optional(map(string), {})
    identity                             = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    timeouts                             = optional(object({
      create = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
}
