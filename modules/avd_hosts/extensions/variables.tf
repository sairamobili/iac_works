variable "avd_session_host_registration" {
  type = map(object({
    name                       = string
    resource_group_name        = string
    location                   = string
    virtual_machine_id         = string
    HostPoolName               = string
    publisher                  = string
    type_handler_version       = string
    type                       = string
    auto_upgrade_minor_version = optional(bool, true)
    registrationinfotoken      = optional(string, null)
  }))
}

variable "avd_enable_aad_for_windows" {
  type = map(object({
    name                 = string
    resource_group_name  = optional(string)
    location             = optional(string)
    virtual_machine_id   = string
    publisher            = string
    type_handler_version = string
    type                 = string
  }))

}
