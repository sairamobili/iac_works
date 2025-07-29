# Diagnostic Setting Module

This Terraform module configures Azure Monitor diagnostic settings for one or more Azure resources.

## Features
- Supports configuring diagnostic settings for any Azure resource that supports diagnostics.
- Allows sending logs and metrics to Event Hub, Log Analytics, and Storage Account.
- Supports dynamic configuration of log and metric categories.

## Usage Example

You can use the sample YAML file under `templates/diagnostic_setting.yml` as a reference for the input structure.
```hcl
# Example using a local source and YAML input
module "diagnostic_setting" {
  source = "./modules/diagnostic_setting"
  diagnostic_settings = yamldecode(file("path/to/diagnostic_setting.yml"))
}

# Example using Azure Repos and YAML input
module "diagnostic_setting" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/azure_iac_modules/azure_iac_modules//modules/diagnostic_setting?ref=master"
  diagnostic_settings = yamldecode(file("path/to/diagnostic_setting.yml"))
}

# Example using GitHub and YAML input
module "diagnostic_setting" {
  source = "git@github.com:hashicorp/example.git"
  diagnostic_settings = yamldecode(file("path/to/diagnostic_setting.yml"))
}
```

## Input Variables
- `dianostic_settings` (list): List of diagnostic setting objects. Each object supports:
  - `name` (string): Name of the diagnostic setting.
  - `target_resource_id` (string): Resource ID to apply diagnostics to.
  - `eventhub_name` (string, optional): Event Hub name.
  - `eventhub_authorization_rule_id` (string, optional): Event Hub authorization rule ID.
  - `log_analytics_workspace_id` (string, optional): Log Analytics workspace ID.
  - `stoage_account_id` (string, optional): Storage Account ID.
  - `log_analytics_destination_type` (string, optional): Destination type for Log Analytics.
  - `patner_solution_id` (string, optional): Partner solution ID.
  - `enabled_log` (object, optional): Log category and group.
  - `enabled_metric` (object, optional): Metric category.

## Resources
- `azurerm_monitor_diagnostic_setting`: Configures the diagnostic settings for the specified resource(s).

## Notes
- All fields marked as optional can be omitted if not required by your scenario.
- The module uses dynamic blocks to only emit log and metric configuration if provided.

---
