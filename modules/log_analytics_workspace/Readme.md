# Log Analytics Workspace Module

This Terraform module creates an Azure Log Analytics Workspace with full support for all parameters and options.

## Features
- Supports all parameters of the azurerm_log_analytics_workspace resource.
- Optional parameters can be omitted from input.
- Outputs all key attributes and secrets.

## Usage Example
```hcl
module "log_analytics_workspace" {
  source              = "./modules/log_analytics_workspace"
  name                = "example-law"
  location            = "eastus"
  resource_group_name = "example-rg"
  sku                 = "PerGB2018"
  # Optional parameters below
  retention_in_days    = 30
  daily_quota_gb       = null
  internet_ingestion_enabled = null
  internet_query_enabled     = null
  reservation_capacity_in_gb_per_day = null
  cmk_for_query_forced = null
  allow_resource_only_permissions = null
  local_authentication_disabled = null
  tags = {
    environment = "dev"
  }
  identity = null
  timeouts = null
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
