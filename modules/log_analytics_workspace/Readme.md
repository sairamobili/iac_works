# Log Analytics Workspace Module

This Terraform module creates an Azure Log Analytics Workspace with full support for all parameters and options.

## Features
- Supports all parameters of the azurerm_log_analytics_workspace resource.
- Optional parameters can be omitted from input.
- Outputs all key attributes and secrets.

## Usage Example

 You can use the sample YAML file under `templates/log_analytics_workspace.yml` as a reference for the input structure.
```hcl
# Example using a local source and YAML input
module "log_analytics_workspace" {
  source = "./modules/log_analytics_workspace"
  workspaces = yamldecode(file("path/to/log_analytics_workspace.yml"))
}

# Example using Azure Repos and YAML input
module "log_analytics_workspace" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/azure_iac_modules/azure_iac_modules//modules/log_analytics_workspace?ref=master"
  workspaces = yamldecode(file("path/to/log_analytics_workspace.yml"))
}

# Example using GitHub and YAML input
module "log_analytics_workspace" {
  source = "git@github.com:hashicorp/example.git"
  workspaces = yamldecode(file("path/to/log_analytics_workspace.yml"))
}
```

## Inputs
- All parameters from the [azurerm_log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) resource are supported as variables.
- Optional parameters can be excluded from input.

## Outputs
- `id`: The resource ID of the workspace.
- `name`: The workspace name.
- `workspace_id`: The customer/workspace ID.
- `primary_shared_key`: The primary shared key.
- `secondary_shared_key`: The secondary shared key.

---
