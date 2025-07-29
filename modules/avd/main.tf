# Validation: Check for duplicate workspace or application group names
resource "null_resource" "validate_unique_names" {
  count = ( length(local.workspace_names) != length(distinct(local.workspace_names)) || 
          length(local.app_group_names) != length(distinct(local.app_group_names))) ? 1 : 0
  triggers = {
    error = "Error: Duplicate workspace or application group names detected. Names must be unique."
  }
}


module "host_pool" {
  source     = "./host_pool"
  host_pools = local.host_pools
}

module "workspace" {
  source     = "./workspace"
  workspaces = local.workspaces
}

module "application_group" {
  source             = "./application_group"
  application_groups = local.application_groups
  host_pool_ids      = module.host_pool.host_pool_ids
  depends_on = [ module.host_pool ]
}



# Workspace-Application Group Associations
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag" {
  for_each             = { for assoc in local.associations : "${assoc.workspace_key}-${assoc.application_group_key}" => assoc if assoc.workspace_key != null && assoc.application_group_key != null }
  workspace_id         = module.workspace.workspace_ids[each.value.workspace_key]
  application_group_id = module.application_group.application_group_ids[each.value.application_group_key]
}

