
locals {
  resource_group    = jsondecode(file("./ccoe/rg.json"))
  vnet_settings     = jsondecode(file("./network/vnet.json"))
  keyvault          = jsondecode(file("./ccoe/keyvault.json"))
  dns_zones         = jsondecode(file("./ccoe/private-dns-zones.json"))
  access_policy     = jsondecode(file("./ccoe/access-policy.json"))
  service-principal = jsondecode(file("./ccoe/service-principal.json"))
  assignments = [
    {
      sp_name              = "secret-api-1",
      scope                = "/subscriptions/9e785b86-3d84-41ac-aae8-3432bdd69ffc",
      role_definition_name = "Contributor"
    },
    {
      sp_name              = "secret-api-2",
      scope                = "/subscriptions/9e785b86-3d84-41ac-aae8-3432bdd69ffc",
      role_definition_name = "Reader"
    }
  ]
}

# module "foundation" {
#   source  = "app.terraform.io/hcta-azure-dev/foundation/azurerm"
#   version = "1.0.5"

#   resource_groups = local.resource_group.resource_groups
#   vnets           = local.vnet_settings.vnets

#   providers = {
#     azurerm = azurerm.subscription1
#   }
# }

# module "modules_keyvault" {
#   source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/keyvault"
#   version = "1.0.5"

#   keyvaults = local.keyvault.keyvaults

#   depends_on = [module.foundation]

#   providers = {
#     azurerm = azurerm.subscription1

#   }
# }

# module "modules_private-dns-zone" {
#   source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/private-dns-zone"
#   version = "1.0.5"

#   zones               = local.dns_zones.zones
#   resource_group_name = local.dns_zones.resource_group_name

#   depends_on = [module.foundation]

#   providers = {
#     azurerm = azurerm.subscription1

#   }
# }


# module "modules_private-endpoint" {
#   source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/private-endpoint"
#   version = "1.0.5"

#   endpoints = {
#     "keyvault-endpoint" : {
#       "name" : "we-ydev-azus-opdx-01-kv01-pe",
#       "resource_group_name" : module.foundation.resource-groups["we-ydev-azus-opdx-marketing-rg"].name,
#       "subnet_id" : module.foundation.subnets["we-ydev-azus-opdx-crm-vnet-keyvault"].id,
#       "private_dns_zone_id" : module.modules_private-dns-zone.dns_zone_ids["privatelink.vaultcore.azure.net"],
#       "location" : "westeurope",
#       "private_connection_resource_id" : module.modules_keyvault.keyvault["we-ydev-azus-opdx-01-kv"].id,
#       "subresource_names" : ["vault"]
#     }
#   }
# }

# module "modules_role-assignment" {
#   source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/role-assignment"
#   version = "1.0.5"

#    azure_rbac = [
#     {
#       key           = "owner on subscription"
#       scope         = "/subscriptions/9e785b86-3d84-41ac-aae8-3432bdd69ffc"
#       role          = "Owner"
#       principal_id  = "524a5584-1475-449c-9813-d26d42903d19"
#     }
#   ]
# }

# module "modules_keyvault-access-policy" {
#   source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/keyvault-access-policy"
#   version = "1.0.5"

#   access_policies = {
#     policy1 = {
#       key_vault_id = module.modules_keyvault.keyvault["we-ydev-azus-opdx-01-kv"].id
#       tenant_id = "233c7c56-1c47-4b81-a976-39ea1da0802a"
#       object_id = "5ac7d1b9-f75b-4f2c-af6a-a0e920e6745c"
#       key_permissions = local.access_policy.policy1.key_permissions
#       secret_permissions = local.access_policy.policy1.secret_permissions
#       certificate_permissions = local.access_policy.policy1.certificate_permissions
#     },
#     policy2 = {
#       key_vault_id = module.modules_keyvault.keyvault["we-ydev-azus-opdx-02-kv"].id
#       tenant_id = "233c7c56-1c47-4b81-a976-39ea1da0802a"
#       object_id = "5ac7d1b9-f75b-4f2c-af6a-a0e920e6745c"
#       key_permissions = local.access_policy.policy2.key_permissions
#       secret_permissions = local.access_policy.policy2.secret_permissions
#       certificate_permissions = local.access_policy.policy2.certificate_permissions
#     },
#     policy3 = {
#       key_vault_id = module.modules_keyvault.keyvault["we-ydev-azus-opdx-01-kv"].id
#       tenant_id = "233c7c56-1c47-4b81-a976-39ea1da0802a"
#       object_id = "da9c795c-fa3b-41f1-ba6a-c9cf69419c28"
#       key_permissions = local.access_policy.policy2.key_permissions
#       secret_permissions = local.access_policy.policy2.secret_permissions
#       certificate_permissions = local.access_policy.policy2.certificate_permissions
#     }
#   }

#   depends_on = [ module.modules_keyvault ]

#   providers = {
#     azurerm = azurerm.subscription1
#   }
# }

module "modules_azuread-role-assignment" {
  source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/azuread-role-assignment"
  version = "1.0.5"

  roles_assignments = [
    {
      role_names = [
        "Global Reader",
        "Attack Payload Author",
        "Application Administrator",
        "Global Administrator",
        "Authentication Administrator",
        "Directory Readers",
        "Directory Writers",
        "License Administrator",
        "User Administrator",
        "Yammer Administrator",
        "Windows 365 Administrator",
        "Service Support Administrator",
        "Extended Directory User Administrator"
      ],
      principal_object_ids = [
        "7b033fe8-52db-43cf-987c-20abac52bf05",
        "524a5584-1475-449c-9813-d26d42903d19",
        "da9c795c-fa3b-41f1-ba6a-c9cf69419c28"
      ]
    }

    ##### Add more role assignments as needed
  ]
}

module "modules_service-principal" {
  source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/service-principal"
  version = "1.0.5"

  service_principals = local.service-principal
  assignments        = local.assignments
}