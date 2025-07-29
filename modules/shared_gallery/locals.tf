locals {
  shared_gallery_definitions = { for sg in try(var.shared_gallery, []) : "${sg.resource_group_name}-${sg.name}" => sg }
  shared_image_definitions = { for sh in flatten([
    for sg in try(var.shared_gallery, []) : [
      for img in try(sg.images, []) : merge(
        img,
        {
          tf_id               = "${sg.resource_group_name}-${sg.name}-${img.name}"
          gallery_name        = sg.name
          resource_group_name = sg.resource_group_name
          location            = sg.location

        }
      )
    ]
    ]) : sh.tf_id => sh
  }
}
