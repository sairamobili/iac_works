resource "azurerm_shared_image" "images" {
  for_each = var.shared_images

  name                = each.value.name
  gallery_name        = each.value.gallery_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  os_type = each.value.os_type

  identifier {
    publisher = each.value.identifier.publisher
    offer     = each.value.identifier.offer
    sku       = each.value.identifier.sku
  }

  dynamic "purchase_plan" {
    for_each = each.value.purchase_plan != null ? [each.value.purchase_plan] : []
    content {
      name      = purchase_plan.value.name
      product   = purchase_plan.value.product
      publisher = purchase_plan.value.publisher
    }
  }

  description                         = each.value.description
  architecture                        = each.value.architecture
  confidential_vm_enabled             = each.value.confidential_vm_enabled
  confidential_vm_supported           = each.value.confidential_vm_supported
  eula                                = each.value.eula
  hyper_v_generation                  = each.value.hyper_v_generation
  min_recommended_vcpu_count          = each.value.min_recommended_vcpu_count
  max_recommended_vcpu_count          = each.value.max_recommended_vcpu_count
  min_recommended_memory_in_gb        = each.value.min_recommended_memory_in_gb
  max_recommended_memory_in_gb        = each.value.max_recommended_memory_in_gb
  specialized                         = each.value.specialized
  trusted_launch_enabled              = each.value.trusted_launch_enabled
  trusted_launch_supported            = each.value.trusted_launch_supported
  accelerated_network_support_enabled = each.value.accelerated_network_support_enabled
  disk_types_not_allowed              = each.value.disk_types_not_allowed
  end_of_life_date                    = each.value.end_of_life_date
  privacy_statement_uri               = each.value.privacy_statement_uri
  release_note_uri                    = each.value.release_note_uri
  hibernation_enabled                 = each.value.hibernation_enabled
  disk_controller_type_nvme_enabled   = each.value.disk_controller_type_nvme_enabled

  tags = each.value.tags
}
