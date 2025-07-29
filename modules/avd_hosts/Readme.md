# AVD Hosts Module

This Terraform module provisions Windows virtual machines (session hosts) for Azure Virtual Desktop (AVD).

## Features
- Accepts a list of VM definitions (name, size, network, OS disk, etc.).
- Dynamically creates network interfaces and VMs.
- Supports custom images and host pool registration.

## Usage Example

You can use the sample YAML file under `templates/avd_hosts.yml` as a reference for the input structure.
```hcl
# Example using a local source and YAML input
module "avd_hosts" {
  source = "./modules/avd_hosts"
  virtual_machines = yamldecode(file("path/to/avd_hosts.yml"))
}

# Example using Azure Repos and YAML input
module "avd_hosts" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/azure_iac_modules/azure_iac_modules//modules/avd_hosts?ref=master"
  virtual_machines = yamldecode(file("path/to/avd_hosts.yml"))
}

# Example using GitHub and YAML input
module "avd_hosts" {
  source = "git@github.com:hashicorp/example.git"
  virtual_machines = yamldecode(file("path/to/avd_hosts.yml"))
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
