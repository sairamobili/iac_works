packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

  source "azure-arm" "avd_image" {
  
    # Azure subscription and resource group details
    location        = var.location
    client_id       = var.client_id
    client_secret   = var.client_secret
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
    #un comment azure cli auth if you want to use azure cli authentication
    # use_azure_cli_auth = true
    # managed_image_resource_group_name = "avd-images"
    # managed_image_name                = "packer-avd-{{timestamp}}"

    # Base image details
    os_type         = var.os_type
    image_publisher = var.image_publisher
    image_offer     = var.image_offer
    image_sku       = var.image_sku
    image_version   = var.image_version

    # VM configuration
    vm_size = var.vm_size

    # WinRM communicator configuration
    communicator   = "winrm"
    winrm_use_ssl  = true
    winrm_insecure = true
    winrm_timeout  = "30m"
    security_type = "TrustedLaunch"
    azure_tags = {
      Purpose = "AVD",
      Updated = "{{timestamp}}"
    }

    shared_image_gallery_destination {
      subscription        = var.subscription_id
      gallery_name        = var.gallery_name
      image_name          = var.image_name
      image_version       = var.shared_gallery_image_version
      resource_group      = var.gallery_resource_group
      replication_regions = ["northeurope"]
    }
    shared_image_gallery_timeout = "2h5m2s"
    # Uncomment and configure the following block if using a custom virtual network
    # temp_resource_group_name               = "avd-images"
    # virtual_network_name                   = "avd-iac-tes02-vnet"
    # virtual_network_subnet_name            = "default"
    # private_virtual_network_with_public_ip = true
    # virtual_network_resource_group_name    = "avd-images"
    # build_resource_group_name              = "avd-images"
    # Uncomment and configure the following block if using a service principal
    # tenant_id        = "xxxx-xxxx"
    # client_id        = "xxxx-xxxx"
    # client_secret    = var.client_secret
  }