# Resource Group Module

This Terraform module manages Azure Resource Groups.

## Features
- Creates resource groups from a list of name/location objects.
- Supports tagging.

## Usage Example
```hcl
# Example using a local source
module "resource_group" {
  source = "./modules/resource_group"
  resource_group_config = [
    {
      name     = "rg1"
      location = "eastus"
      tags     = {
        Environment = "dev"
      }
    }
  ]
}

# Example using a remote git source
module "resource_group" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/avd/avd//modules/resource_group?ref=master"
  resource_group_config = [
    # ...same as above...
  ]
}
```

## Input Variables
- `resource_group_config` (list): List of resource group objects (name, location, tags).

---
