terraform {
  required_version = ">=1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.81.0"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    random = {
      source = "hashicorp/random"
    }
    time = {
      source = "hashicorp/time"
    }

  }
}

# provider "azurerm" {
#   features {}
#   subscription_id = "58d48d30-bf14-416f-92ed-254430cc6772"
# }

provider "azurerm" {
  features {}
  subscription_id = "58d48d30-bf14-416f-92ed-254430cc6772"
}

provider "azurerm" {
  features {}
  alias           = "subscription1"
  subscription_id = "58d48d30-bf14-416f-92ed-254430cc6772"
}

provider "azurerm" {
  features {}
  alias           = "sandbox"
  subscription_id = "305f81c7-dc9e-4f49-97f7-edea3620656d"
}

provider "azuread" {
  # Configure the azuread provider...
}

provider "random" {
  # Configure the random provider...
}

provider "time" {
  # Configure the time_rotating provider...
}