resource "azurerm_shared_image_gallery" "shared_gallery" {
  for_each            = { for sh in var.shared_gallery : "${sh.resource_group_name}-${sh.name}" => sh }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  description         = each.value.description

  # Only emit sharing if defined
  dynamic "sharing" {
    for_each = each.value.sharing != null ? [each.value.sharing] : []
    content {
      permission = sharing.value.permission

      # Only emit community_gallery if defined
      dynamic "community_gallery" {
        for_each = sharing.value.community_gallery != null ? [sharing.value.community_gallery] : []
        content {
          eula            = community_gallery.value.eula
          prefix          = community_gallery.value.prefix
          publisher_email = community_gallery.value.publisher_email
          publisher_uri   = community_gallery.value.publisher_uri
        }
      }
    }
  }
}

module "shared_images" {
  source        = "./shared_image"
  shared_images = local.shared_image_definitions
  depends_on = [ azurerm_shared_image_gallery.shared_gallery ]
}
