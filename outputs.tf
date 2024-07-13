output "resource-groups" {
  value       = module.spoke.resource-groups
  description = "value of resource-groups"
}

output "vnets" {
  value       = module.spoke.vnets
  description = "value of vnets"
}

output "subnets" {
  value       = module.spoke.subnets
  description = "value of subnets"
  
}

output "keyvaults" {
  value       = module.spoke.keyvaults
  description = "value of keyvaults"
}

output "dns_zones" {
  value       = module.spoke.dns_zones
  description = "value of dns_zones"
}