# AVD Hosts Module

This Terraform module provisions Windows virtual machines (session hosts) for Azure Virtual Desktop (AVD).

## Features
- Accepts a list of VM definitions (name, size, network, OS disk, etc.).
- Dynamically creates network interfaces and VMs.
- Supports custom images and host pool registration.

## Usage Example
```hcl
# Example using a local source
module "avd_hosts" {
  source = "./modules/avd_hosts"
  virtual_machines = [
    {
      name                = "vm1"
      resource_group_name = "rg1"
      location            = "eastus"
      size                = "Standard_D2s_v3"
      admin_username      = "azureuser"
      count               = 1
      nw_resource_group_name = "rg1"
      nw_virual_network_name = "vnet1"
      nw_subnet_name         = "subnet1"
      os_disk = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }
  ]
}

# Example using a remote git source
module "avd_hosts" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/avd/avd//modules/avd_hosts?ref=master"
  virtual_machines = [
    # ...same as above...
  ]
}
```

## Input Variables
- `virtual_machines` (list): List of VM objects with detailed configuration (see `variables.tf`).

## Outputs
- `virtual_machines_list`: List of created VMs.
- `aad_enable_for_windows`: AAD enablement status.
- `avd_desktop_session_host_registration`: Registration info for session hosts.

## Submodules
- `network_interfaces`
- `extensions`

---
