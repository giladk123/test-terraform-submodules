
locals {
  resource_group          = jsondecode(file("./ccoe/rg.json"))
}

module "spoke" {
  source  = "app.terraform.io/hcta-azure-dev/spoke/azurerm"
  version = "1.0.1"
 
  resource_groups = local.resource_group.resource_groups
  
  providers = {
    azurerm = azurerm.subscription1
  }
}

