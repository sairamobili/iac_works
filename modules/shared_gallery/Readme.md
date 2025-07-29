# Shared Gallery Module

This Terraform module manages Azure Shared Image Gallery and images.

## Features
- Creates shared image galleries and images from configuration.
- Supports sharing (including community gallery).

## Usage Example
```hcl
# Example using a local source
module "shared_gallery" {
  source = "./modules/shared_gallery"
  shared_gallery = [
    {
      name                = "gallery1"
      resource_group_name = "rg1"
      location            = "eastus"
      description         = "Shared images."
      sharing = {
        permission = "Groups"
      }
      images = []
    }
  ]
}

# Example using a remote git source
module "shared_gallery" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/avd/avd//modules/shared_gallery?ref=master"
  shared_gallery = [
    # ...same as above...
  ]
}
```

## Input Variables
- `shared_gallery` (list): List of gallery objects, each with images and sharing options.

## Submodules
- `shared_image`

---
