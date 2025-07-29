output "scaling_plan_ids" {
  description = "Map of scaling plan resource IDs, keyed by <resource_group_name>-<name>."
  value = { for k, sp in azurerm_virtual_desktop_scaling_plan.this : k => sp.id }
}

output "scaling_plan_names" {
  description = "Map of scaling plan names, keyed by <resource_group_name>-<name>."
  value = { for k, sp in azurerm_virtual_desktop_scaling_plan.this : k => sp.name }
}
