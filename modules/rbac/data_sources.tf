data "azuread_user" "this" {
  for_each = { for idx, assignment in var.assignments : idx => assignment if assignment.identity_type == "user" }
  user_principal_name = each.value.identity
}

data "azuread_group" "this" {
  for_each = { for idx, assignment in var.assignments : idx => assignment if assignment.identity_type == "group" }
  display_name = each.value.identity
}

data "azuread_service_principal" "this" {
  for_each = { for idx, assignment in var.assignments : idx => assignment if assignment.identity_type == "service_principal" }
  display_name = each.value.identity
}

data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "this" {
  for_each = { for idx, assignment in var.assignments : idx => assignment if assignment.scope_type == "resource_group" }
  name = each.value.scope_name
}

data "azurerm_resource" "this" {
  for_each = { for idx, assignment in var.assignments : idx => assignment if assignment.scope_type == "resource" }
  name                 = each.value.scope_name
  resource_group_name  = each.value.resource_group_name
  resource_type        = each.value.resource_type
}
