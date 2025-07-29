resource "azurerm_network_interface" "nic" {
  for_each            = var.network_interfaces
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  # Optional NIC settings
  dns_servers                    = each.value.dns_servers
  accelerated_networking_enabled = each.value.accelerated_networking_enabled
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled

  # Single nested block—no indexing
  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = each.value.ip_configuration.subnet_id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
    private_ip_address_version    = each.value.ip_configuration.private_ip_address_version
    public_ip_address_id          = each.value.ip_configuration.public_ip_address_id
    primary                       = each.value.ip_configuration.primary

  }
}
