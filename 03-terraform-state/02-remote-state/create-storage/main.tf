# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.20.0"
    }
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

#create resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-terraexample-remote-state-storage"
  location = "westus2"
}

resource "random_string" "random" {
  length           = 16
  special          = false
  upper            = false
}

resource "azurerm_storage_account" "sa" {
  name                     = "${random_string.random.result}sta"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  blob_properties {
    versioning_enabled = true
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "terraformdemo"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}