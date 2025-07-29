variable "network_interfaces" {
  description = "List of network interface configurations for virtual machines, including all required and optional parameters."
  type = map(object({
    # Required fields
    name = string
    # Optional NIC settings
    location                       = string
    resource_group_name            = string
    dns_servers                    = optional(list(string), null)
    accelerated_networking_enabled = optional(bool, false)
    ip_forwarding_enabled          = optional(bool, false)
    # IP configuration (required list)
    ip_configuration = object({
      # Required fields
      name      = string
      subnet_id = string
      # Optional fields
      private_ip_address_allocation                = optional(string, "Dynamic") # Changed to Dynamic for safety
      private_ip_address_version                   = optional(string, "IPv4")
      private_ip_address                           = optional(string, null)
      public_ip_address_id                         = optional(string, null)
      primary                                      = optional(bool, false)
      application_gateway_backend_address_pool_ids = optional(list(string), null)
      load_balancer_backend_address_pool_ids       = optional(list(string), null)
      load_balancer_inbound_nat_rules_ids          = optional(list(string), null)
    })
    application_security_group_ids = optional(list(string), null)
  }))

}

