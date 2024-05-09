terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.100.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.48.0"
    }
  }
}


provider "azurerm" {
  subscription_id = "69179890-562f-4b1c-a581-32b99007e051"
  tenant_id = "25b50dfa-c8f3-4bf9-957d-9e7cc1734a87"
  client_id = "4b22eaf2-875e-4e73-904c-8f9c68129bf1"
  client_secret = var.client_secret
  features {}
}




