# Resource Group Module

This Terraform module manages Azure Resource Groups.

## Features
- Creates resource groups from a list of name/location objects.
- Supports tagging.

## Usage Example

You can use the sample YAML file under `template/resource_group.yml` as a reference for the input structure.
```hcl
# Example using a local source and YAML input
module "resource_group" {
  source = "./modules/resource_group"
  resource_group_config = yamldecode(file("path/to/resource_group.yml"))
}

# Example using Azure Repos and YAML input
module "resource_group" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/iacworks/azure_iac_modules/azure_iac_modules//modules/resource_group?ref=master"
  resource_group_config = yamldecode(file("path/to/resource_group.yml"))
}

# Example using GitHub and YAML input
module "resource_group" {
  source = "git@github.com:hashicorp/example.git"
  resource_group_config = yamldecode(file("path/to/resource_group.yml"))
}
```

## Input Variables
- `resource_group_config` (list): List of resource group objects (name, location, tags).

---
