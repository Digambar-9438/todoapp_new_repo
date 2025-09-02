terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.40.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "239f86cf-d0d2-4954-935f-40e39253100c"

}