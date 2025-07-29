locals {
  subscription_id             = data.azurerm_subscription.current.subscription_id
  subnet_id_format            = "/subscriptions/${local.subscription_id}/resourceGroups/%s/providers/Microsoft.Network/virtualNetworks/%s/subnets/%s"
  virtual_machine_id_format   = "/subscriptions/${local.subscription_id}/resourceGroups/%s/providers/Microsoft.Compute/virtualMachines/%s"
  network_interface_id_format = "/subscriptions/${local.subscription_id}/resourceGroups/%s/providers/Microsoft.Network/networkInterfaces/%s"

  subnet_list = distinct(flatten([
    for vm in try(var.virtual_machines, []) : {
      name = vm.nw_subnet_name
      virtual_network_name = vm.nw_virual_network_name
      resource_group_name = vm.nw_resource_group_name
    }
  ]))

  subnet_map = {for snet in local.subnet_list: "${snet.resource_group_name}-${snet.virtual_network_name}-${snet.name}" => snet}
  avd_network_interfaces_list = flatten([
    for vm in try(var.virtual_machines, []) : [
      for idx in range(tonumber(vm.count)) : {
        tf_key              = "nic-${vm.resource_group_name}-${vm.name}-${idx}"
        name                = "nic-${vm.name}-${idx}"
        resource_group_name = vm.resource_group_name
        location            = vm.location
        id                  = format(local.network_interface_id_format, vm.resource_group_name, "nic-${vm.name}-${idx}")
        ip_configuration = {
          name                          = "ipconfig-${vm.name}-${idx}"
          subnet_id                     = data.azurerm_subnet.subnet["${vm.nw_resource_group_name}-${vm.nw_virual_network_name}-${vm.nw_subnet_name}"].id
          private_ip_address_allocation = "Dynamic"
          primary                       = true
        }
      }
  ]])

  avd_network_interfaces_definitions = { for nic in local.avd_network_interfaces_list : nic.tf_key => nic }

  virtual_machines_list = flatten([
    for vm in try(var.virtual_machines, []) : [
      for idx in range(tonumber(vm.count)) : merge(vm, {
        tf_key                = "vm-${vm.resource_group_name}-${vm.name}-${idx}"
        name                  = "${vm.name}-${idx}"
        id                    = format(local.virtual_machine_id_format, vm.resource_group_name, "${vm.name}-${idx}")
        network_interface_ids = distinct([local.avd_network_interfaces_definitions["nic-${vm.resource_group_name}-${vm.name}-${idx}"].id])
        os_disk = {
          name                             = "vm-osdisk-${vm.name}-${idx}"
          caching                          = try(vm.os_disk.caching, "ReadWrite")
          storage_account_type             = try(vm.os_disk.storage_account_type, "Standard_LRS")
          disk_size_gb                     = try(vm.os_disk.disk_size_gb, null)
          write_accelerator_enabled        = try(vm.os_disk.write_accelerator_enabled, false)
          disk_encryption_set_id           = try(vm.os_disk.disk_encryption_set_id, null)
          secure_vm_disk_encryption_set_id = try(vm.os_disk.secure_vm_disk_encryption_set_id, null)
          security_encryption_type         = try(vm.os_disk.security_encryption_type, null)
        }
      })
    ]
  ])

  virtual_desktop_session_host_registration_list = flatten([
    for vm in local.virtual_machines_list : {
      tf_key                     = "avd-host-reginfo-${vm.resource_group_name}-${vm.name}"
      name                       = "${vm.resource_group_name}-${vm.name}-reginfo"
      resource_group_name        = vm.resource_group_name
      location                   = vm.location
      virtual_machine_id         = azurerm_windows_virtual_machine.vm[vm.tf_key].id
      HostPoolName               = vm.HostPoolName
      publisher                  = "Microsoft.Powershell"
      type_handler_version       = "2.83"
      type                       = "DSC"
      auto_upgrade_minor_version = "true"
      registrationinfotoken      = var.avd_registration_token[format("%s-%s", vm.host_pool_resource_group_name, vm.HostPoolName)]
    }
  ])

  avd_desktop_session_host_registration = {
    for vm in local.virtual_desktop_session_host_registration_list : vm.tf_key => vm
  }

  avd_enable_aad_for_windows_list = flatten([
    for vm in local.virtual_machines_list : {
      tf_key               = "avd-aad-windows-${vm.resource_group_name}-${vm.name}"
      name                 = "${vm.resource_group_name}-${vm.name}-aad-windows"
      resource_group_name  = vm.resource_group_name
      location             = vm.location
      virtual_machine_id   = azurerm_windows_virtual_machine.vm[vm.tf_key].id
      publisher            = "Microsoft.Azure.ActiveDirectory"
      type_handler_version = "2.0"
      type                 = "AADLoginForWindows"
    }

  ])
  avd_enable_aad_for_windows = {
    for vm in local.avd_enable_aad_for_windows_list : vm.tf_key => vm
  }
}
