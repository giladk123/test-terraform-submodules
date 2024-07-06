output "resource-groups" {
  value = module.spoke.resource-groups
  description = "value of resource-groups"
}

output "vnets" {
  value = module.spoke.vnets
  description = "value of vnets"
}