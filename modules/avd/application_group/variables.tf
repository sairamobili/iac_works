variable "application_groups" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    type                = string
    host_pool_name      = string
    friendly_name       = optional(string)
    description         = optional(string)
  }))
  description = "Map of application group configurations."
}

variable "host_pool_ids" {
  type        = map(string)
  description = "Map of host pool IDs."
}