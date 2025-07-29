variable "resource_group_config" {
  type = list(object({
    name     = string
    location = string
    tags     = optional(map(string))
  }))

  default     = []
  nullable    = false
  description = "Configuration for the Azure Resource Group."
  
}