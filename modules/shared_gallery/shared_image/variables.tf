variable "shared_images" {
  description = "A map of Azure Shared Image configurations"
  type = map(object({
    name                = string
    gallery_name        = string
    resource_group_name = string
    location            = string
    os_type             = string
    identifier = object({
      publisher = string
      offer     = string
      sku       = string
    })
    purchase_plan = optional(object({
      name      = string
      product   = string
      publisher = string
    }))
    description                         = optional(string)
    architecture                        = optional(string, "x64")
    confidential_vm_enabled             = optional(bool, null)
    confidential_vm_supported           = optional(bool, null)
    eula                                = optional(string)
    hyper_v_generation                  = optional(string)
    min_recommended_vcpu_count          = optional(number)
    max_recommended_vcpu_count          = optional(number)
    min_recommended_memory_in_gb        = optional(number)
    max_recommended_memory_in_gb        = optional(number)
    specialized                         = optional(bool, false)
    trusted_launch_enabled              = optional(bool, null)
    trusted_launch_supported            = optional(bool, null)
    accelerated_network_support_enabled = optional(bool, false)
    disk_types_not_allowed              = optional(list(string), [])
    end_of_life_date                    = optional(string)
    privacy_statement_uri               = optional(string)
    release_note_uri                    = optional(string)
    hibernation_enabled                 = optional(bool, null)
    disk_controller_type_nvme_enabled   = optional(bool, null)
    tags                                = optional(map(string), {})
  }))
  default = {}
}
