# Example Terraform configuration for testing commit
terraform {
    required_version = ">= 1.12.2"

    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = ">= 3.0.0"
        }
    }
}

# provider "azurerm" {
#     features {
    
#     }
# }

