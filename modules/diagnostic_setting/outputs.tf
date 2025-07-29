output "diagnostic_setting_ids" {
  description = "IDs of the created diagnostic settings."
  value = [for ds in azurerm_monitor_diagnostic_setting.diagnostic_settings : ds.id]
}

output "diagnostic_setting_names" {
  description = "Names of the created diagnostic settings."
  value = [for ds in azurerm_monitor_diagnostic_setting.diagnostic_settings : ds.name]
}
