
locals {
  resource_group          = jsondecode(file("./ccoe/rg.json"))
  vnet_settings           = jsondecode(file("./network/vnet.json"))
  keyvault_settings       = jsondecode(file("./ccoe/keyvault.json"))
}

module "spoke" {
  source  = "app.terraform.io/hcta-azure-dev/spoke/azurerm"
  version = "1.0.13"
 
  resource_groups = local.resource_group.resource_groups
  vnets = local.vnet_settings.vnets
  keyvaults = local.keyvault_settings.keyvaults
  providers = {
    azurerm = azurerm.subscription1
  }
}

