# AVD Module

This Terraform module deploys Azure Virtual Desktop (AVD) resources using a YAML-driven configuration.

## Features
- Loads AVD configuration from a YAML file (`avd_yaml` variable).
- Manages host pools, workspaces, and application groups as submodules.
- Validates uniqueness of workspace and application group names.
- Associates workspaces and application groups.

## Usage Example

You can use the sample YAML file under `templates/avd_config.yml` as a reference for the input structure.
```hcl
# Example using a local source and YAML input
module "avd" {
  source   = "./modules/avd"
  avd_yaml = file("path/to/avd_config.yml")
}

# Example using Azure Repos and YAML input
module "avd" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/azure_iac_modules/azure_iac_modules//modules/avd?ref=master"
  avd_yaml = file("path/to/avd_config.yml")
}

# Example using GitHub and YAML input
module "avd" {
  source = "git@github.com:hashicorp/example.git"
  avd_yaml = file("path/to/avd_config.yml")
}
```

## Input Variables
- `avd_yaml` (string): Path to the YAML configuration file for AVD resources.

## Outputs
- `avd_host_pool_ids`: Map of host pool IDs.
- `avd_workspace_ids`: Map of workspace IDs.
- `avd_application_group_ids`: Map of application group IDs.
- `avd_host_pool_registration_info`: Map of host pool registration information.

## Submodules
- `host_pool`
- `workspace`
- `application_group`

---
