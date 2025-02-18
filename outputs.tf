# output "resource-groups" {
#   value       = module.foundation.resource-groups
#   description = "value of resource-groups"
# }

# output "vnets" {
#   value       = module.foundation.vnets
#   description = "value of vnets"
# }

# output "subnets" {
#   value       = module.foundation.subnets
#   description = "value of subnets"
# }

# output "keyvaults" {
#   value       = module.modules_keyvault.keyvault
#   description = "value of keyvaults"
# }

# output "dns_zones" {
#   value       = module.modules_private-dns-zone.dns_zone_ids
#   description = "value of dns_zones"
# }

# output "private-endpoint" {
#   value       = module.modules_private-endpoint.private_endpoints
#   description = "value of private-endpoint"
# }

# output "role_assignments" {
#   value       = module.modules_role-assignment.role_assignments
#   description = "value of role_assignments"
# }

# output "access_policies" {
#   description = "Access policies applied to the key vault"
#   value       = module.modules_keyvault-access-policy.access_policies
# }

output "role_assignments_details_from_module" {
  value       = module.modules_azuread-role-assignment.role_assignments_details
  description = "A map of Azure AD role assignments including role IDs and principal object IDs from the azuread_role_assignment module."
}

output "app_registration_client_secret" {
  value       = module.modules_service-principal.app_registration_client_secret
  description = "The client secret generated for the Azure AD app registration."
  sensitive = true
}

output "app_registration_object_id" {
  value       = module.modules_service-principal.app_registration_object_id
  description = "The object ID of the Azure AD app registration."
}

output "app_registration_application_id" {
  value       = module.modules_service-principal.app_registration_application_id
  description = "The application ID of the Azure AD app registration."
}

output "sp_object_id" {
  value       = module.modules_service-principal.sp_object_id
  description = "The object ID of the service principal."
}

output "sp_application_id" {
  value       = module.modules_service-principal.sp_application_id
  description = "The application ID of the service principal."
}

output "management_groups" {
  value      = module.modules_management-group.management_groups
  description = "Access policies applied to the key vault"
}