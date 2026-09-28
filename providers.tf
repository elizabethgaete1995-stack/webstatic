terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.64.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  alias           = "app"
  subscription_id = var.static_web_app_subscription_id
  features {}
}

provider "azurerm" {
  alias           = "network"
  subscription_id = var.network_subscription_id
  features {}
}
