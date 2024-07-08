output "resource-groups" {
  value = module.spoke.resource-groups
  description = "value of resource-groups"
}

output "vnets" {
  value = module.spoke.vnets
  description = "value of vnets"
}

output "keyvaults" {
  value = module.spoke.keyvaults
  description = "value of keyvaults"
}