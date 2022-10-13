# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.20.0"
    }
  }
   backend "azurerm" {
    resource_group_name  = "rg-terraexample-remote-state-storage"
    storage_account_name = "terrastatestorage2188"
    container_name       = "terraformdemo"
    key                  = "dev.terraform.tfstate"
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

