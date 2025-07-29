# Shared Gallery Module

This Terraform module manages Azure Shared Image Gallery and images.

## Features
- Creates shared image galleries and images from configuration.
- Supports sharing (including community gallery).

## Usage Example

You can use the sample YAML file under `templates/shared_gallery.yml` as a reference for the input structure.
```hcl
# Example using a local source and YAML input
module "shared_gallery" {
  source = "./modules/shared_gallery"
  shared_gallery = yamldecode(file("path/to/shared_gallery.yml"))
}

# Example using Azure Repos and YAML input
module "shared_gallery" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/azure_iac_modules/azure_iac_modules//modules/shared_gallery?ref=master"
  shared_gallery = yamldecode(file("path/to/shared_gallery.yml"))
}

# Example using GitHub and YAML input
module "shared_gallery" {
  source = "git@github.com:hashicorp/example.git"
  shared_gallery = yamldecode(file("path/to/shared_gallery.yml"))
}
```

## Input Variables
- `shared_gallery` (list): List of gallery objects, each with images and sharing options.

## Submodules
- `shared_image`

---
