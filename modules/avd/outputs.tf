# Outputs
output "avd_host_pool_ids" {
  value       = module.host_pool.host_pool_ids
  description = "Map of host pool IDs."
}

output "avd_workspace_ids" {
  value       = module.workspace.workspace_ids
  description = "Map of workspace IDs."
}

output "avd_application_group_ids" {
  value       = module.application_group.application_group_ids
  description = "Map of application group IDs."
}

output "avd_host_pool_registration_info" {
  value       = module.host_pool.host_pool_registration_info
  description = "Map of host pool registration information."
  
}