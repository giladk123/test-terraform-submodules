
locals {
  resource_group    = jsondecode(file("./ccoe/rg.json"))
  vnet_settings     = jsondecode(file("./network/vnet.json"))
  keyvault_settings = jsondecode(file("./ccoe/keyvault.json"))
  dns_zones         = jsondecode(file("./ccoe/private-dns-zones.json"))
}

module "spoke" {
  source  = "app.terraform.io/hcta-azure-dev/spoke/azurerm"
  version = "1.0.19"

  resource_groups     = local.resource_group.resource_groups
  vnets               = local.vnet_settings.vnets
  keyvaults           = local.keyvault_settings.keyvaults
  zones               = local.dns_zones.zones
  resource_group_name = local.dns_zones.resource_group_name
  providers = {
    azurerm = azurerm.subscription1
  }
}

module "spoke_private-endpoint" {
  source  = "app.terraform.io/hcta-azure-dev/spoke/azurerm//modules/private-endpoint"
  version = "1.0.19"
  # insert required variables here
  
  endpoints = {
    "keyvault-endpoint": {
      "name": "we-ydev-azus-opdx-01-kv01-pe",
      "resource_group_name": module.spoke.resource-groups["we-ydev-azus-opdx-arutzim-rg"].name,
      "subnet_id": module.spoke.subnet["we-ydev-azus-opdx-crm-vnet-keyvault"].id,
      "private_dns_zone_id": module.spoke.dns_zones["privatelink.vaultcore.azure.net"],
      "location": "westeurope",
      "private_connection_resource_id": module.spoke.keyvaults["we-ydev-azus-opdx-01-kv"].id,
      "subresource_names": ["vault"]
    }
  }

  depends_on = [ module.spoke ]

  providers = {
    azurerm = azurerm.subscription1
  }
}
