variable "workspaces" {
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    friendly_name                 = optional(string)
    description                   = optional(string)
    public_network_access_enabled = optional(bool, true)
    tags                          = optional(map(string))
  }))
  description = "Map of workspace configurations."
}