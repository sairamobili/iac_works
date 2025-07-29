locals {
  principal_ids = {
    for idx, assignment in var.assignments :
    idx => assignment.identity_type == "user" ? data.azuread_user.this[idx].id :
           assignment.identity_type == "group" ? data.azuread_group.this[idx].id :
           assignment.identity_type == "service_principal" ? data.azuread_service_principal.this[idx].id :
           null
  }
  scopes = {
    for idx, assignment in var.assignments :
    idx => assignment.scope_type == "subscription" ? data.azurerm_subscription.current.id :
           assignment.scope_type == "resource_group" ? data.azurerm_resource_group.this[idx].id :
           assignment.scope_type == "resource" ? data.azurerm_resource.this[idx].id :
           null
  }
}
