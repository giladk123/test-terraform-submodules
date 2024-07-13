output "resource-groups" {
  value       = module.foundation.resource-groups
  description = "value of resource-groups"
}

output "vnets" {
  value       = module.foundation.vnets
  description = "value of vnets"
}

output "subnets" {
  value       = module.foundation.subnets
  description = "value of subnets"
}

output "keyvaults" {
  value       = module.modules_keyvault.keyvault
  description = "value of keyvaults"
}

output "dns_zones" {
  value       = module.modules_private-dns-zone.dns_zone_ids
  description = "value of dns_zones"
}

output "private-endpoint" {
  value       = module.modules_private-endpoint.private_endpoints
  description = "value of private-endpoint"
}