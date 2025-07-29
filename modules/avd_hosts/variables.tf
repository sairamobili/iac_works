variable "virtual_machines" {
  description = "List of virtual machine configurations, including all required and optional parameters for VMs, NICs, and disks."
  type = list(object({
    # VM-specific settings (required fields)
    name                   = string
    resource_group_name    = string
    location               = string
    size                   = string
    admin_username         = string
    count                  = number # Default to 1 if not specified
    nw_resource_group_name = string
    nw_virual_network_name = string
    nw_subnet_name         = string

    # below hostpool settings are required to fetch the registration token of the host pool
    host_pool_resource_group_name = optional(string, null) # Optional, can be null if not using host pools 
    HostPoolName                = optional(string, null) # Optional, can be null if not using host pools

    # Optional VM settings
    admin_password = optional(string, null) # Can be null; module may require it for Windows VMs
    # network_interface_ids = list(string)        # Populated by module, not user-provided

    # OS disk configuration
    os_disk = object({
      # Required fields
      caching              = string
      storage_account_type = string
      # Optional fields
      disk_size_gb                     = optional(number, null)
      name                             = optional(string, null)
      write_accelerator_enabled        = optional(bool, false)
      disk_encryption_set_id           = optional(string, null)
      secure_vm_disk_encryption_set_id = optional(string, null)
      security_encryption_type         = optional(string, null)

    })

    # Optional VM image and plan settings
    source_image_id = optional(string, null)
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }), null)
    plan = optional(object({
      name      = string
      publisher = string
      product   = string
    }), null)

    # Other optional VM settings
    license_type                      = optional(string, null)
    availability_set_id               = optional(string, null)
    proximity_placement_group_id      = optional(string, null)
    dedicated_host_id                 = optional(string, null)
    vm_agent_platform_updates_enabled = optional(bool, false)
    patch_mode                        = optional(string, "AutomaticByOS")
    enable_automatic_updates          = optional(bool, true)
    timezone                          = optional(string, null)
    user_data                         = optional(string, null)
    capacity_reservation_group_id     = optional(string, null)
    zone                              = optional(string, null)
    tags                              = optional(map(string), {})
    secure_boot_enabled               = optional(bool, false)
    vtpm_enabled                      = optional(bool, false)
    # Optional identity block
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string), null)
    }), null)

    # Optional boot diagnostics
    boot_diagnostics = optional(object({
      storage_account_uri = optional(string, null)
    }), null)

    # Optional additional capabilities
    additional_capabilities = optional(object({
      ultra_ssd_enabled = bool
    }), null)

    # Optional WinRM listeners
    winrm_listeners = optional(list(object({
      protocol        = string
      certificate_url = optional(string, null)
    })), null)

    # Optional secrets
    secrets = optional(list(object({
      key_vault_id = string
      certificate = list(object({
        url   = string
        store = string
      }))
    })), null)

    # Optional data disks (defaults to empty list)
    data_disks = optional(list(object({
      # Required fields for each data disk
      name                 = string
      storage_account_type = string
      # disk_size_gb is required in Azure for new disks, but optional here; module must validate
      disk_size_gb = optional(number, null)
      # Other optional fields
      lun                        = optional(number, null)
      caching                    = optional(string, "None")
      create_option              = optional(string, "Empty")
      disk_encryption_set_id     = optional(string, null)
      write_accelerator_enabled  = optional(bool, false)
      on_demand_bursting_enabled = optional(bool, false)
    })), [])


  }))
}

variable "avd_registration_token" {
  description = "Map of AVD host pool registration tokens by host pool key."
  type        = map(string)
  nullable    = true
}

