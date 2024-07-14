
locals {
  resource_group = jsondecode(file("./ccoe/rg.json"))
  vnet_settings  = jsondecode(file("./network/vnet.json"))
  keyvault       = jsondecode(file("./ccoe/keyvault.json"))
  dns_zones      = jsondecode(file("./ccoe/private-dns-zones.json"))

}

module "foundation" {
  source  = "app.terraform.io/hcta-azure-dev/foundation/azurerm"
  version = "1.0.3"

  resource_groups = local.resource_group.resource_groups
  vnets           = local.vnet_settings.vnets

  providers = {
    azurerm = azurerm.subscription1
  }
}

module "modules_keyvault" {
  source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/keyvault"
  version = "1.0.1"

  keyvaults = local.keyvault.keyvaults

  depends_on = [module.foundation]

  providers = {
    azurerm = azurerm.subscription1

  }
}

module "modules_private-dns-zone" {
  source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/private-dns-zone"
  version = "1.0.1"

  zones               = local.dns_zones.zones
  resource_group_name = local.dns_zones.resource_group_name

  depends_on = [module.foundation]

  providers = {
    azurerm = azurerm.subscription1

  }
}


module "modules_private-endpoint" {
  source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/private-endpoint"
  version = "1.0.1"

  endpoints = {
    "keyvault-endpoint" : {
      "name" : "we-ydev-azus-opdx-01-kv01-pe",
      "resource_group_name" : module.foundation.resource-groups["we-ydev-azus-opdx-marketing-rg"].name,
      "subnet_id" : module.foundation.subnets["we-ydev-azus-opdx-crm-vnet-keyvault"].id,
      "private_dns_zone_id" : module.modules_private-dns-zone.dns_zone_ids["privatelink.vaultcore.azure.net"],
      "location" : "westeurope",
      "private_connection_resource_id" : module.modules_keyvault.keyvault["we-ydev-azus-opdx-01-kv"].id,
      "subresource_names" : ["vault"]
    }
  }
}

module "modules_role-assignment" {
  source  = "app.terraform.io/hcta-azure-dev/modules/azurerm//modules/role-assignment"
  version = "1.0.1"
  
   azure_rbac = [
    {
      key           = "owner on subscription"
      scope         = "/subscriptions/9e785b86-3d84-41ac-aae8-3432bdd69ffc"
      role          = "Owner"
      principal_id  = "5ac7d1b9-f75b-4f2c-af6a-a0e920e6745c"
    }
  ]
}