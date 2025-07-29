# Virtual Desktop Auto Scaling Plan Module

This Terraform module creates one or more Azure Virtual Desktop Scaling Plans with best practices for flexibility and automation.

## Features
- Supports creation of multiple scaling plans in a single module call.
- Handles all parameters of the azurerm_virtual_desktop_scaling_plan resource.
- Supports complex schedules and host pool references.
- Outputs all scaling plan IDs and names for downstream use.

## Usage Example
```hcl
module "auto_scaling_plan" {
  source = "./modules/auto_scaling_plan"
  scaling_plans = [
    {
      name                = "example-scaling-plan"
      resource_group_name = "rg-avd"
      location            = "eastus"
      time_zone           = "UTC"
      host_pool_type      = "Pooled"
      schedule = [
        {
          days_of_week                        = ["Monday", "Tuesday"]
          ramp_up_start_time                  = "06:00"
          ramp_up_load_balancing_algorithm    = "BreadthFirst"
          ramp_up_minimum_hosts_percent       = 10
          ramp_up_capacity_threshold_percent  = 20
          peak_start_time                     = "09:00"
          peak_load_balancing_algorithm       = "DepthFirst"
          peak_minimum_hosts_percent          = 50
          off_peak_start_time                 = "18:00"
          off_peak_load_balancing_algorithm   = "BreadthFirst"
          off_peak_minimum_hosts_percent      = 20
          off_peak_capacity_threshold_percent = 10
          ramp_down_start_time                = "22:00"
          ramp_down_load_balancing_algorithm  = "DepthFirst"
          ramp_down_minimum_hosts_percent     = 5
          ramp_down_capacity_threshold_percent= 5
        }
      ]
      host_pool_references = [
        {
          hostpool_id            = azurerm_virtual_desktop_host_pool.example.id
          scaling_plan_enabled   = true
        }
      ]
      tags = {
        environment = "dev"
      }
    }
  ]
}
```

## Inputs
- All parameters from the [azurerm_virtual_desktop_scaling_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_scaling_plan) resource are supported as variables.
- Optional parameters can be excluded from input.

## Outputs
- `scaling_plan_ids`: Map of scaling plan resource IDs.
- `scaling_plan_names`: Map of scaling plan names.

---
