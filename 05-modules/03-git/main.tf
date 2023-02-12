#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-${var.name}"
    location = "westus"
}

#Git Azure DevOps
module "storage_account1" {
  source    = "git::https://allanore@dev.azure.com/allanore/TerraformModulesExample/_git/TerraformModulesExample?ref=v0.1"

  saname    = "tfdemo${var.name}sta"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}

#GitHub
module "storage_account2" {
  source    = "github.com/allanore/TerraformModulesExample"

  saname    = "tfdemo${var.name}2sta"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}

#Terraform registry
module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.0.0"
  # insert the 3 required variables here
  resource_group_name = azurerm_resource_group.rg.name
  use_for_each        = true
  vnet_location       = azurerm_resource_group.rg.location
}
