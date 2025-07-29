# Virtual Desktop Auto Scaling Plan Module

This Terraform module creates one or more Azure Virtual Desktop Scaling Plans with best practices for flexibility and automation.

## Features
- Supports creation of multiple scaling plans in a single module call.
- Handles all parameters of the azurerm_virtual_desktop_scaling_plan resource.
- Supports complex schedules and host pool references.
- Outputs all scaling plan IDs and names for downstream use.

## Usage Example

You can use the sample YAML file under `templates/auto_scaling_plans.yml` as a reference for the input structure.
```hcl
# Example using a local source and YAML input
module "auto_scaling_plan" {
  source = "./modules/auto_scaling_plan"
  scaling_plans = yamldecode(file("path/to/auto_scaling_plans.yml"))
}

# Example using Azure Repos and YAML input
module "auto_scaling_plan" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/azure_iac_modules/azure_iac_modules//modules/auto_scaling_plan?ref=master"
  scaling_plans = yamldecode(file("path/to/auto_scaling_plans.yml"))
}

# Example using GitHub and YAML input
module "auto_scaling_plan" {
  source = "git@github.com:hashicorp/example.git"
  scaling_plans = yamldecode(file("path/to/auto_scaling_plans.yml"))
}
```

## Inputs
- All parameters from the [azurerm_virtual_desktop_scaling_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_scaling_plan) resource are supported as variables.
- Optional parameters can be excluded from input.

## Outputs
- `scaling_plan_ids`: Map of scaling plan resource IDs.
- `scaling_plan_names`: Map of scaling plan names.

---
