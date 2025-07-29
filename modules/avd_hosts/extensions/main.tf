resource "azurerm_virtual_machine_extension" "avd_session_host_registration" {
  for_each             = var.avd_session_host_registration
  name                 = each.value.name
  virtual_machine_id   = each.value.virtual_machine_id
  publisher            = each.value.publisher
  type                 = each.value.type
  type_handler_version = each.value.type_handler_version

  settings           = <<-SETTINGS
    {
      "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_1.0.02748.388.zip",
      "configurationFunction": "Configuration.ps1\\AddSessionHost",
      "properties": {
        "HostPoolName":"${each.value.HostPoolName}",
        "aadJoin": true,
        "UseAgentDownloadEndpoint": true,
        "aadJoinPreview": false
      }
    }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
      "properties": {
        "registrationInfoToken": "${each.value.registrationinfotoken}"
      }
    }
  PROTECTED_SETTINGS


}

resource "azurerm_virtual_machine_extension" "avd_enable_aad_for_windows" {
  for_each             = var.avd_enable_aad_for_windows
  name                 = each.value.name
  publisher            = each.value.publisher
  virtual_machine_id   = each.value.virtual_machine_id
  type_handler_version = each.value.type_handler_version
  type                 = each.value.type

}
