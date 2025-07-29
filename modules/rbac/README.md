# RBAC Module

This module assigns Azure RBAC roles to users, groups, or service principals on specified scopes using friendly names (UPN, group name, or service principal name) and generates scope IDs internally.

## Input Variables
- `assignments`: List of objects with:
  - `identity`: UPN, group name, or service principal name
  - `identity_type`: `user`, `group`, or `service_principal`
  - `role_definition_name`: Azure role name (e.g., `Reader`)
  - `scope_type`: `resource_group`, `resource`, or `subscription`
  - `scope_name`: Name of the resource group, resource, or subscription (for `resource`, use the resource name)
  - `resource_type`: (Optional) Resource type, required if `scope_type` is `resource`
  - `resource_group_name`: (Optional) Resource group name, required if `scope_type` is `resource`

## Example Usage

```hcl
module "rbac" {
  source = "./modules/rbac"
  assignments = [
    {
      identity             = "user1@contoso.com"
      identity_type        = "user"
      role_definition_name = "Reader"
      scope_type           = "resource_group"
      scope_name           = "my-rg"
    },
    {
      identity             = "MyGroup"
      identity_type        = "group"
      role_definition_name = "Contributor"
      scope_type           = "subscription"
      scope_name           = "<subscription_name>" # Not used, but required for structure
    },
    {
      identity             = "my-app-sp"
      identity_type        = "service_principal"
      role_definition_name = "Owner"
      scope_type           = "resource"
      scope_name           = "my-vm"
      resource_type        = "Microsoft.Compute/virtualMachines"
      resource_group_name  = "my-rg"
    }
  ]
}
```

## Outputs
- `role_assignment_ids`: List of created role assignment IDs.
