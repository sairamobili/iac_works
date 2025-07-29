module "network_interfaces" {
  source             = "./network_interfaces"
  network_interfaces = local.avd_network_interfaces_definitions
}

resource "azurerm_windows_virtual_machine" "vm" {
  for_each = { for vm in local.virtual_machines_list : vm.tf_key => vm }

  # Required VM settings
  name                  = each.value.name
  resource_group_name   = each.value.resource_group_name
  location              = each.value.location
  size                  = each.value.size
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  network_interface_ids = each.value.network_interface_ids

  # OS disk configuration
  os_disk {
    caching                          = each.value.os_disk.caching
    storage_account_type             = each.value.os_disk.storage_account_type
    disk_size_gb                     = each.value.os_disk.disk_size_gb
    name                             = each.value.os_disk.name
    write_accelerator_enabled        = each.value.os_disk.write_accelerator_enabled
    disk_encryption_set_id           = each.value.os_disk.disk_encryption_set_id
    secure_vm_disk_encryption_set_id = each.value.os_disk.secure_vm_disk_encryption_set_id
    security_encryption_type         = each.value.os_disk.security_encryption_type
  }
  boot_diagnostics {}
  # Optional VM image and plan settings
  dynamic "source_image_reference" {
    for_each = each.value.source_image_reference != null ? [each.value.source_image_reference] : []
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

  source_image_id = each.value.source_image_id

  dynamic "plan" {
    for_each = each.value.plan != null ? [each.value.plan] : []
    content {
      name      = plan.value.name
      publisher = plan.value.publisher
      product   = plan.value.product
    }
  }

  # Other optional VM settings
  license_type                  = each.value.license_type
  availability_set_id           = each.value.availability_set_id
  proximity_placement_group_id  = each.value.proximity_placement_group_id
  dedicated_host_id             = each.value.dedicated_host_id
  patch_mode                    = each.value.patch_mode
  enable_automatic_updates      = each.value.enable_automatic_updates
  timezone                      = each.value.timezone
  user_data                     = each.value.user_data
  capacity_reservation_group_id = each.value.capacity_reservation_group_id
  zone                          = each.value.zone
  tags                          = each.value.tags
  secure_boot_enabled           = each.value.secure_boot_enabled
  vtpm_enabled                  = each.value.vtpm_enabled

  # Optional identity block
  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # Optional boot diagnostics
  dynamic "boot_diagnostics" {
    for_each = each.value.boot_diagnostics != null ? [each.value.boot_diagnostics] : []
    content {
      storage_account_uri = boot_diagnostics.value.storage_account_uri
    }
  }

  # Optional additional capabilities
  dynamic "additional_capabilities" {
    for_each = each.value.additional_capabilities != null ? [each.value.additional_capabilities] : []
    content {
      ultra_ssd_enabled = additional_capabilities.value.ultra_ssd_enabled
    }
  }

  # Optional WinRM listeners
  dynamic "winrm_listener" {
    for_each = each.value.winrm_listeners != null ? each.value.winrm_listeners : []
    content {
      protocol        = winrm_listener.value.protocol
      certificate_url = winrm_listener.value.certificate_url
    }
  }

  # Optional secrets
  dynamic "secret" {
    for_each = each.value.secrets != null ? each.value.secrets : []
    content {
      key_vault_id = secret.value.key_vault_id
      dynamic "certificate" {
        for_each = secret.value.certificate
        content {
          url   = certificate.value.url
          store = certificate.value.store
        }
      }
    }
  }

  depends_on = [module.network_interfaces]
}

module "extensions" {
  source = "./extensions"
  avd_session_host_registration = local.avd_desktop_session_host_registration
  avd_enable_aad_for_windows    = local.avd_enable_aad_for_windows

  # Pass the virtual machine IDs to the extensions
}
