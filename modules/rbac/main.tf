# RBAC module for assigning roles to users/groups/service principals on Azure resources

variable "assignments" {
  description = "List of RBAC assignments."
  type = list(object({
    identity           = string # UPN, group name, or service principal name
    identity_type      = string # 'user', 'group', or 'service_principal'
    role_definition_name = string
    scope_type         = string # 'resource_group', 'resource', or 'subscription'
    scope_name         = string # Name of the resource group, resource, or subscription
    resource_type      = optional(string) # Required if scope_type == 'resource'
    resource_group_name = optional(string) # Required if scope_type == 'resource'
  }))
}

resource "azurerm_role_assignment" "this" {
  for_each = { for idx, assignment in var.assignments : idx => assignment }

  principal_id         = local.principal_ids[each.key]
  role_definition_name = each.value.role_definition_name
  scope                = local.scopes[each.key]
}
