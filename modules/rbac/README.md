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

You can use the sample YAML file under `templates/rbac_assignments.yml` as a reference for the input structure.
```hcl
# Example using a local source and YAML input
module "rbac" {
  source = "./modules/rbac"
  assignments = yamldecode(file("path/to/rbac_assignments.yml"))
}

# Example using Azure Repos and YAML input
module "rbac" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/azure_iac_modules/azure_iac_modules//modules/rbac?ref=master"
  assignments = yamldecode(file("path/to/rbac_assignments.yml"))
}

# Example using GitHub and YAML input
module "rbac" {
  source = "git@github.com:hashicorp/example.git"
  assignments = yamldecode(file("path/to/rbac_assignments.yml"))
}
```

## Outputs
- `role_assignment_ids`: List of created role assignment IDs.
