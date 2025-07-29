# Image Build Module

This folder contains Packer templates and scripts for building custom VM images for Azure.

## Features
- Packer HCL files for Azure image builds.
- Pipeline and script automation for image creation.

## Usage Example
```hcl
# Example using a local source
module "image_build" {
  source = "./modules/image_build"
  # add variables here
}

# Example using a remote git source
module "image_build" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/avd/avd//modules/image_build?ref=master"
  # add variables here
}
```
