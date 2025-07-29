variable "assignments" {
  description = "List of RBAC assignments."
  type = list(object({
    identity             = string # UPN, group name, or service principal name
    identity_type        = string # 'user', 'group', or 'service_principal'
    role_definition_name = string
    scope_type           = string # 'resource_group', 'resource', or 'subscription'
    scope_name           = string # Name of the resource group, resource, or subscription
    resource_type        = optional(string) # Required if scope_type == 'resource'
    resource_group_name  = optional(string) # Required if scope_type == 'resource'
  }))

  validation {
    condition = length(var.assignments) == length(distinct([for a in var.assignments :
      join("|", [a.identity, a.identity_type, a.role_definition_name, a.scope_type, a.scope_name, coalesce(a.resource_type, ""), coalesce(a.resource_group_name, "")])
    ]))
    error_message = "Duplicate RBAC assignments detected (same identity, role, and scope). Each assignment must be unique."
  }
}
