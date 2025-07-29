locals {
  avd_config = yamldecode(var.avd_yaml)

  # Create maps with composite keys (resource_group_name-name) for uniqueness

  host_pools         = { for hp in try(local.avd_config.host_pools, []) : "${hp.resource_group_name}-${hp.name}" => hp }
  workspaces         = { for ws in try(local.avd_config.workspaces, []) : "${ws.resource_group_name}-${ws.name}" => ws }
  application_groups = { for ag in try(local.avd_config.application_groups, []) : "${ag.resource_group_name}-${ag.name}" => ag }
  # associations      = try(local.avd_config.associations, [])
  rbac_assignments      = try(local.avd_config.rbac_assignments, [])
  # application_group_ids = { for ag in local.application_groups : "${ag.resource_group_name}-${ag.name}" => ag.id }
  # Map workspace and application group names to their composite keys
  workspace_name_to_key = { for k, ws in local.workspaces : ws.name => k }
  app_group_name_to_key = { for k, ag in local.application_groups : ag.name => k }

  # Process associations by mapping names to composite keys
  associations = flatten([
    for assoc in try(local.avd_config.associations, []) : [
      for ag_name in try(assoc.application_groups, []) : {
        workspace_key         = try(local.workspace_name_to_key[assoc.workspace], null)
        application_group_key = try(local.app_group_name_to_key[ag_name], null)
      }
      if try(local.workspace_name_to_key[assoc.workspace], null) != null &&
      try(local.app_group_name_to_key[ag_name], null) != null &&
      # Ensure workspace and application group are in the same resource group
      try(split("-", local.workspace_name_to_key[assoc.workspace])[0], null) == try(split("-", local.app_group_name_to_key[ag_name])[0], null)
    ]
  ])

  # Default tags for consistency
  default_tags = {
    Environment = "AVD"
    ManagedBy   = "Terraform"
  }

  # Extract lists of workspace and application group names for validation
  workspace_names = [for ws in try(local.avd_config.workspaces, []) : ws.name]
  app_group_names = [for ag in try(local.avd_config.application_groups, []) : ag.name]
}