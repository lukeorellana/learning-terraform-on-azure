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